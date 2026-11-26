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
