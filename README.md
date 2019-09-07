# OmniWheel

## Current Architecture

The Controller handles the business logic.
The View is actually the view model.
The ViewRenderer is actually the view.

The View creates and holds a reference to the Frame before passing it to the ViewRenderer (which should probably be the one doing that).

## Next Architecture
- [] Rename some things
  - Controller -> Action Producers
  - View -> State
  - ViewRenderer -> View
- [] Move the Frame out of State and into the View
- [] Change State#Show and State#Hide into "visibility setters."
- [] Move EventTarget out from State and into the View.
- [] Make Action Producers stateless (just functions).
- [] Action Producers should mutate State.
