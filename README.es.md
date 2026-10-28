# Orden manual para la bandeja de KDE Plasma

Implementacion reproducible para ordenar de forma persistente los iconos de la
bandeja del sistema y arrastrarlos directamente tanto en el panel como en la
ventana de iconos ocultos.

## Incluye

- Parches completos para Plasma Workspace 6.7.5.
- Variante aislada `org.kde.plasma.systemtray.ordered` que no sustituye el
  applet oficial.
- Orden desde Configurar -> Elementos con controles accesibles.
- Persistencia por IDs estables, incluso al cerrar y reabrir aplicaciones.
- Pruebas QtTest y arneses CMake que no compilan todo Plasma Workspace.
- Instalacion de usuario sin `sudo`, respaldo y reversion exacta.
- Parche adicional limpio sobre el MR 6958 activo de KDE.
- Rama de codigo revisable en el
  [fork publico de Plasma Workspace](https://github.com/e-kala/plasma-workspace/tree/feature/system-tray-direct-drag-mr6958).
- [Guia estructurada para agentes de IA](AI_IMPLEMENTATION_GUIDE.md), para no
  tener que redescubrir la arquitectura ni recodificar la solucion.

## Instalacion rapida en Plasma 6.7.5

```sh
git clone https://github.com/e-kala/kde-plasma-systray-order.git
cd kde-plasma-systray-order
./scripts/quick-install-v6.7.5.sh
```

El script prepara, compila e instala un plugin con ID separado dentro de
`~/.local`. No reinicia Plasma, no modifica el panel y no escribe en `/usr`.
Consulta [docs/INSTALL.md](docs/INSTALL.md) para activarlo y revertirlo.

## Procedencia

El modelo de orden, la configuracion y sus pruebas proceden del trabajo de
**Ramil Nurmanov** en el
[MR 6958 de KDE](https://invent.kde.org/plasma/plasma-workspace/-/merge_requests/6958).
Este proyecto aporta el arrastre directo, la adaptacion probada a 6.7.5, la
variante coexistente y el flujo reproducible para comunidad e IA.

Solicitud original: [KDE Bug 384782](https://bugs.kde.org/show_bug.cgi?id=384782).
