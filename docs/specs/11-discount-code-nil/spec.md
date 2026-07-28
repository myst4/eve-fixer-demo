> Spec: **Código de descuento nulo en checkout** · Issue: #11 · Base: main · Estado: Draft · Fecha: 2026-07-26

# Problema
`DiscountCode#normalized` (`app/services/discount_code.rb:9`) llama a `raw.strip`
asumiendo que el código llega siempre como String. Cuando el POST a
`/checkout/apply_discount` se envía con el campo de código vacío o ausente, el
parámetro llega como `nil` y `normalized` levanta
`NoMethodError: undefined method 'strip' for nil`. `valid?` (línea 13) propaga el
mismo error porque delega en `normalized`.

Reproducido con test unitario:

```
DiscountCodeTest#test_rejects_a_nil_code:
NoMethodError: undefined method 'strip' for nil
    app/services/discount_code.rb:9:in 'DiscountCode#normalized'
    app/services/discount_code.rb:13:in 'DiscountCode#valid?'
```

88 eventos y 34 usuarios afectados en producción.

# Criterios de aceptación
- [ ] Dado un código `nil` Cuando se llama a `normalized` Entonces devuelve `""` sin levantar excepción.
- [ ] Dado un código `nil` Cuando se llama a `valid?` Entonces devuelve `false`.
- [ ] Dado un código con espacios y minúsculas Cuando se normaliza Entonces se sigue devolviendo en mayúsculas y sin espacios.

# Plan de verificación
`bin/rails test test/services/discount_code_test.rb` (falla antes del fix con
`NoMethodError`, pasa después) y el gate completo `bash scripts/verify.sh`.
