> Spec: **Tipo de cambio faltante en la conversión de moneda** · Issue: #12 · Base: main · Estado: Draft · Fecha: 2026-07-26

# Problema

`GET /invoices/:id/download` explota con `NoMethodError: undefined method 'multiplier' for nil`
(214 eventos, 96 usuarios en production).

`Pricing::CurrencyConverter#rate` (`app/services/pricing/currency_converter.rb:22-23`)
busca la fila del par con `ExchangeRate.find_by(base: from, quote: to)` y llama
`row.multiplier` sin comprobar que la búsqueda haya devuelto algo. Cuando no
existe fila para el par, `row` es `nil` y la llamada revienta.

Se reproduce en el sandbox forzando `ExchangeRate.find_by` a devolver `nil`:

```
NoMethodError: undefined method 'multiplier' for nil
app/services/pricing/currency_converter.rb:23:in 'Pricing::CurrencyConverter#rate'
app/services/pricing/currency_converter.rb:14:in 'Pricing::CurrencyConverter#convert'
app/services/pricing/order_pricer.rb:15:in 'Pricing::OrderPricer#breakdown'
```

Hay dos causas distintas detrás del mismo `nil`:

1. **Par misma-moneda**: `Pricing::OrderPricer#converter` construye siempre el
   converter con `from: order[:currency], to: display_currency`, también cuando
   ambos son iguales. No existe (ni tiene sentido que exista) una fila `EUR→EUR`
   en `exchange_rates`, así que toda factura mostrada en la moneda del pedido
   falla. Esto explica el volumen del error.
2. **Par realmente ausente**: falta la fila del par en la tabla (carga nocturna
   incompleta o moneda nueva). Ahí no hay valor correcto que devolver.

# Criterios de aceptación

- [ ] Dado un pedido cuya moneda es igual a la moneda de visualización, cuando se
      convierte un importe, entonces se devuelve el importe sin cambios y no se
      consulta ningún tipo de cambio.
- [ ] Dado un par de monedas distintas sin fila en `exchange_rates`, cuando se
      convierte un importe, entonces se lanza `CurrencyConverter::MissingRate`
      con el par en el mensaje, en lugar de `NoMethodError`.
- [ ] Dado un par con fila en `exchange_rates`, cuando se convierte un importe,
      entonces se aplica `multiplier` y se redondea igual que antes.

# Plan de verificación

- `bin/rails test test/services/pricing/currency_converter_test.rb`: los tests de
  par ausente y de misma-moneda fallan antes del fix y pasan después.
- `bash scripts/verify.sh` en verde.
