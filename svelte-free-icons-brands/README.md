# svelte-free-icons-brands

The free-icons set is a collection of over 23,000 freely available icons for various design projects.

This repository contains scripts to port the entire [free-icons](https://free-icons.github.io/free-icons/) set to Svelte and generates npm packages to be used in your Svelte projects.

## Icons Organization

The free-icons contains 23661 icons grouped in the following way:

- 554 `brand` icons
- 3301 `thin` icons
- 3301 `light` icons
- 3301 `regular` icons
- 3301 `solid` icons
- 3301 `sharp light` icons
- 3301 `sharp regular` icons
- 3301 `sharp solid` icons

## Svelte pakages name

The Svelte packages are named accordingly:

- svelte-free-icons-brand
- svelte-free-icons-thin
- svelte-free-icons-light
- svelte-free-icons-regular
- svelte-free-icons-solid
- svelte-free-icons-sharp-slight
- svelte-free-icons-sharp-regular
- svelte-free-icons-sharp-solid

## Svelte components names

The name of Svelte Icons (components) is based on original icon's name according this simple rule:

- word1-word2-...-wordN -> Word1Word2...WordN

Let's see few examples:

- apartment -> Apartment.svelte
- arrow-down-a-z -> ArrowDownAZ.svelte
- bed-empty -> BedEmpty.svelte

Particular attention should be put to icons which start with a digit:

- 0 -> Zero.svelte
- 1 -> One.svelte
- ...
- 42-group -> FourtwoGroup.svelte

Pretty obvious !!! :)

## How to use Svelte icons

### Install icons pack

```bash
npm -i -D svelte-free-icons-brand
npm -i -D svelte-free-icons-thin
npm -i -D svelte-free-icons-light
npm -i -D svelte-free-icons-regular
npm -i -D svelte-free-icons-solid
npm -i -D svelte-free-icons-sharp-slight
npm -i -D svelte-free-icons-sharp-regular
npm -i -D svelte-free-icons-sharp-solid
```

### import and use it in your .svelte component

```js
import { Github } from 'svelte-free-icons-brand';
import { Wifi } from 'svelte-free-icons-thin';
import { SquareParking } from 'svelte-free-icons-light';
import { CourtSport } from 'svelte-free-icons-regular';
import { Command } from 'svelte-free-icons-solid';
import { Diamon } from 'svelte-free-icons-sharp-slight';
import { DoorOpen } from 'svelte-free-icons-sharp-regular';
import { Dolphin } from 'svelte-free-icons-sharp-solid';
...
...
...

<Github /> <!-- lighgray 1rem icon -->
<Wifi />

<SquareParking color="red" size="2rem" /> <!-- red 2rem icon -->
<CourtSport class="my own class" /> <!-- specify your own classes -->
<Command />
<Diamon color="#080808" />
<DoorOpen />
<Dolphin color="blue" size="3rem" />
```
