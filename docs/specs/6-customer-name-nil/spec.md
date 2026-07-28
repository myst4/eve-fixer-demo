> Spec: **Nombre de cliente sin apellido** · Issue: #6 · Base: main · Estado: Draft · Fecha: 2026-07-26

# Problema

`orders#index` rompe con `NoMethodError: undefined method 'strip' for nil` (63 eventos,
21 usuarios, production). El stack de la app es:

```
app/services/customer_name.rb:28 CustomerName#last_name
app/services/customer_name.rb:9  CustomerName#full
app/views/orders/index.html.erb:14
```

El root cause está en `CustomerName#last_name`: hacía `customer[:last_name].strip`
asumiendo que el apellido siempre está presente. Cuando el cliente no tiene apellido
cargado, `customer[:last_name]` es `nil` (clave ausente o valor nulo) y `nil.strip`
revienta. El comentario de `CustomerName#full` documenta explícitamente el caso
"just 'Ada' when there is no last name", así que el contrato ya contemplaba el
apellido vacío; la implementación no.

Reproducción con un test unitario:

```
$ bin/rails test test/services/customer_name_test.rb
NoMethodError: undefined method 'strip' for nil
    app/services/customer_name.rb:26:in 'CustomerName#last_name'
    app/services/customer_name.rb:9:in 'CustomerName#full'
5 runs, 3 assertions, 0 failures, 2 errors, 0 skips
```

# Criterios de aceptación

- [ ] Dado un cliente sin la clave `:last_name`, cuando se pide `CustomerName#full`,
      entonces devuelve solo el nombre (`"Ada"`) sin espacios sobrantes.
- [ ] Dado un cliente con `last_name: nil`, cuando se pide `CustomerName#full`,
      entonces devuelve solo el nombre (`"Ada"`) y no se levanta `NoMethodError`.
- [ ] Dado un cliente con nombre y apellido, cuando se pide `CustomerName#full` o
      `CustomerName#short`, entonces el formato actual no cambia.

# Plan de verificación

- `bin/rails test test/services/customer_name_test.rb`: los dos tests nuevos fallan
  antes del fix con el `NoMethodError` del issue y pasan después.
- `bash scripts/verify.sh` en verde.
