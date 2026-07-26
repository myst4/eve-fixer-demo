# Convenciones del repo

Repo de prueba para el agente fixer. Espeja las convenciones de club_envios.

## Stack

- Rails 8 sobre Ruby 3.4 (**alpine** — el contenedor no tiene bash, usar `sh -lc`)
- Tests: **Minitest** bajo `test/`
- Gate: `bash scripts/verify.sh` — espeja CI

## Flujo

1. Todo trabajo arranca con un issue en el board.
2. Branch desde la rama base: `fix/<numero-de-issue>-<slug-corto>`.
3. El PR va hacia la rama base con `Refs #<n>` en el body.
4. Commits en español con **Conventional Commits**: prefijo en inglés
   (`feat`, `fix`, `chore`, `refactor`, `docs`, `test`), descripción en español.

## Documentación

Todo bugfix con comportamiento observable lleva un Mini-Spec en
`docs/specs/<numero-de-issue>-<slug>/spec.md`, y **viaja en el mismo PR** que el
código. Nunca un commit aparte.

```markdown
> Spec: **<Nombre legible>** · Issue: #<n> · Base: <rama> · Estado: Draft · Fecha: <YYYY-MM-DD>

# Problema
Qué está mal y cómo se reproduce (el root cause encontrado, no una hipótesis).

# Criterios de aceptación
- [ ] Dado … Cuando … Entonces …

# Plan de verificación
Cómo se comprueba el fix.
```

## Reglas duras

- Nunca commitear con el gate en rojo.
- Nunca rescatar una excepción para silenciar el error.
- Diff mínimo: sin reformateos ni refactors del código vecino.
