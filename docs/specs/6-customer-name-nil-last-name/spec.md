> Spec: **Apellido nulo en CustomerName** · Issue: #6 · Base: main · Estado: Draft · Fecha: 2026-07-26

# Problema

`orders#index` rompe con `NoMethodError: undefined method 'strip' for nil`
(63 eventos, 21 usuarios, solo production). El frame superior es
`app/services/customer_name.rb:26` en `CustomerName#last_name`, que hace
`customer[:last_name].strip`. Cuando el cliente no tiene apellido —la clave
llega con `nil` o directamente no viene en el hash— el `strip` se invoca sobre
`nil` y explota. El comentario de `#full` ya documenta el caso soportado
("just \"Ada\" when there is no last name"), así que el contrato esperaba el
apellido ausente pero la implementación no lo cubría.

Reproducido con un test unitario nuevo:

```
CustomerNameTest#test_usa_solo_el_nombre_cuando_el_apellido_es_nil:
NoMethodError: undefined method 'strip' for nil
    app/services/customer_name.rb:26:in 'CustomerName#last_name'
    app/services/customer_name.rb:9:in 'CustomerName#full'
```

# Criterios de aceptación

- [ ] Dado un cliente con `last_name: nil`, cuando se pide `#full`, entonces
      devuelve solo el nombre (`"Ada"`) sin espacios sobrantes.
- [ ] Dado un cliente sin la clave `:last_name`, cuando se pide `#full`,
      entonces devuelve solo el nombre (`"Ada"`).
- [ ] Dado un cliente con `last_name: nil`, cuando se pide `#short`, entonces
      devuelve `"A."` sin espacio final.
- [ ] Dado un cliente con apellido presente (incluso con espacios alrededor),
      entonces el formato actual no cambia (`"Ada Lovelace"` / `"A. Lovelace"`).

# Plan de verificación

- `bin/rails test test/services/customer_name_test.rb`: los tres tests nuevos
  fallan con el `NoMethodError` antes del fix y pasan después.
- `bash scripts/verify.sh` en verde.
