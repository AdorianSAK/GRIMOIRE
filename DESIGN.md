# GRIMOIRE
### A Dungeon Master's Workstation

## 1. Purpose

GRIMOIRE is a command-driven tabletop RPG companion designed to assist Game Masters during preparation and gameplay.

Its primary purpose is to manage game information, automate bookkeeping, track entities and resources, and provide quick access to rules and documentation without unnecessarily interrupting the flow of a session.

GRIMOIRE is not a campaign manager, nor is it intended to replace the Game Master. It is a flexible workstation that allows the GM to maintain control over their game while delegating repetitive calculations and record-keeping to the software.

## 2. Design Philosophy

### 2.1 The Game Master is authoritative

GRIMOIRE assists the GM but does not enforce how a game must be played.

The GM can create, modify, remove, and manipulate game entities and resources as necessary. The software provides consistency and convenience, not restrictions on the GM's decisions.

### 2.2 Collections are independent resources

Collections contain reusable definitions, templates, rules, and other resources.

They exist independently of individual Games and can be expanded, modified, cloned, imported, and exported.

### 2.3 Games are independent saved worlds

Each Game represents an independent, persistent world state, comparable to a videogame save slot.

A Game owns its actors, objects, encounters, world information, history, and other runtime data.

Games do not contain campaigns or depend on one another.

### 2.4 Instances are independent entities

Instances are created from Collection definitions and belong to individual Games.

Once instantiated, they can evolve independently of their original definitions. Changes to an instance must never unintentionally modify its source definition.

Instances can be modified, transferred, archived, recovered, exported, or permanently deleted.

### 2.5 Minimize bookkeeping

GRIMOIRE should avoid requiring the GM to maintain the same information in multiple places.

Related systems should remain synchronized automatically whenever possible. For example, inventory-backed resources must use inventory quantities as their source of truth.

### 2.6 Preserve gameplay flow

Commands should be concise, expressive, and consistent.

Operations should be accessible through different interfaces without duplicating their underlying logic.

### 2.7 Atomicity and consistency

An operation must either complete successfully or leave the Game unchanged.

Failed operations must not leave partially modified entities, inventories, resources, or other game data.

### 2.8 Extensibility

GRIMOIRE should support different RPG systems, custom rules, content collections, and future mechanics without requiring its fundamental architecture to be redesigned.

## 3. System Architecture

GRIMOIRE is organized around two independent environments: Collections and Games.

### 3.1 Collections

Collections are global repositories of reusable content. They exist independently of individual Games and provide the definitions and reference material used to populate them.

Collections may contain:

- Character definitions.
- Creature definitions (Bestiary).
- Item definitions.
- Troop definitions.
- Recipes and crafting definitions.
- Rules and reference documentation.

Definitions can be created, modified, cloned, imported, and exported.

#### Cloning

Cloning creates a new, independent definition based on an existing one.

The cloned definition:
- Receives its own unique identity.
- Contains a complete copy of the source definition's properties.
- Can be modified without affecting its source.
- Retains provenance identifying its origin.

There are no permanent inheritance dependencies between cloned definitions.

### 3.2 Games

A Game is an independent, persistent world state, comparable to a videogame save slot.

Each Game manages its own:
- Actor instances.
- Object instances.
- Encounters and combat state.
- World information.
- History.
- Trash.

Instances belong to their respective Games and cannot affect instances in other Games.

Multiple Games may contain entities with identical display names. Internal identities must remain unique.

### 3.3 Separation of Collections and Games

Collections provide reusable definitions. Games contain independent instances created from those definitions.

Using a definition to create an instance must never modify the original definition.

Modifying an instance must never unintentionally modify its source definition.

Exporting an instance creates a new Collection definition, preserving its provenance while allowing the GM to decide which instance properties should be included.

Deleting a Game must not delete or modify its Collections.