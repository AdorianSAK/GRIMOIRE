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

#### Multiple Collection Libraries

GRIMOIRE should eventually support multiple independent Collection libraries.

This will allow users to organize and maintain different RPG systems, homebrew content, personal creations, and third-party content packs independently.

Examples:

- D&D 5e
- Pathfinder
- Homebrew
- Personal Collections
- Third-party content packs

Multiple libraries should be able to coexist without unintentionally modifying or conflicting with one another.

This functionality is planned for a future implementation milestone.

## Definitions and Instances

GRIMOIRE distinguishes between reusable definitions and independent instances.

### Definitions

A Definition is a reusable blueprint stored in a Collection.

Examples include:
- A Goblin definition in the Bestiary.
- An Iron Sword definition in the Item Collection.
- A character definition in the Character Collection.
- A Skeleton Squad definition in the Troop Collection.

Definitions describe the properties and capabilities of something before it is introduced into a Game.

### Instances

An Instance is an independent entity created from a Definition and stored within a specific Game.

When a Definition is instantiated, GRIMOIRE creates an independent snapshot of its properties.

Changes made to the original Definition must not automatically affect existing Instances. Likewise, modifying an Instance must never unintentionally modify its source Definition.

Each Instance belongs to its Game and maintains its own identity and state.

Examples:
- Goblin_A and Goblin_B can originate from the same Goblin definition.
- Each Goblin has independent HP, initiative, conditions, inventory, and other properties.
- Albor's Iron Sword can have different properties from another Iron Sword instance, such as enchantments, durability, or ownership.

### Cloning Definitions

Definitions can be cloned to create new, independent Definitions.

Cloning must:
- Create a new unique identity.
- Copy the source Definition's properties.
- Preserve information about the source Definition.
- Allow unrestricted modification of the new Definition.
- Avoid maintaining a live dependency on the original.

A cloned Definition is independent. Future changes to its source must not propagate into it.

Cloning a clone is also permitted.

### Instance Modification

Instances are not restricted to temporary gameplay changes.

The GM may permanently modify an Instance's properties during a Game. These modifications belong exclusively to that Instance.

For example, a Goblin might acquire new abilities, mutations, equipment, or permanent stat changes. Its original Bestiary Definition remains untouched.

### Exporting Instances

An Instance can be exported into a Collection as a new Definition.

The GM decides which properties should be included in the exported Definition.

Temporary gameplay state and Game-specific information should not be included automatically. For example, current HP, temporary conditions, carried currency, and individual inventory contents should be treated separately from reusable defining properties.

Exporting an Instance must never modify or remove the original Instance.

### Identity and Provenance

Every Definition and Instance must have a unique internal identity independent of its display name.

Display names are intended for human interaction and may be changed or reused. Internal identities ensure that renaming an entity does not break its references or historical records.

GRIMOIRE should also preserve provenance: information describing where an entity originated and how it was created or modified.

Provenance is historical information, not a live inheritance relationship.

## Actors and Objects

GRIMOIRE organizes Game entities into two broad families: Actors and Objects.

Both originate from Definitions stored in Collections and become independent Instances when introduced into a Game.

### Actors

An Actor represents an entity capable of acting within the Game.

Examples include:
- Player characters.
- Creatures and monsters.
- NPCs.
- Companions.
- Summoned entities.

Actors share a common foundation of properties and capabilities, such as:
- Identity and descriptive information.
- Attributes and statistics.
- Hit points.
- Conditions and status effects.
- Inventory.
- Resources and abilities.

Not every Actor is a Player Character.

A Player Character is a specialized Actor with additional character-related properties, such as class, level, experience, background, and progression.

An Actor may acquire these additional properties without losing its original identity or characteristics. For example, a Goblin converted into a Player Character remains a Goblin while gaining the properties necessary to manage it as a character.

The system should favor composition and optional capabilities over rigid inheritance between entity types.

### Objects

An Object represents an entity that can be possessed, manipulated, consumed, equipped, transferred, or otherwise interacted with.

Examples include:
- Weapons and armor.
- Potions and consumables.
- Food and ingredients.
- Crafting materials.
- Ammunition.
- Quest items.
- Miscellaneous equipment.

Objects have properties appropriate to their purpose, such as weight, value, quantity, durability, effects, and equipment-related information.

An Object Instance may also have properties that differ from its original Definition.

For example, two Iron Sword Instances may share the same original Definition but have different durability, enchantments, or ownership.

### Inventory and Object Ownership

An Actor's inventory maintains references to the Objects it possesses.

Physical item quantities must have a single source of truth. Inventory quantities must not be duplicated by independent resource counters.

Objects may be:
- Added to or removed from an inventory.
- Transferred between Actors.
- Equipped or unequipped.
- Consumed.
- Destroyed.

Identical Objects may be represented as a quantity stack when their relevant properties and state are equivalent.

Objects with different individual properties or states must be represented as separate Instances when necessary.

### Shared Instance Management

Actors and Objects are both Game-specific Instances.

They share common lifecycle requirements, including:
- Unique internal identity.
- Provenance.
- Modification.
- History tracking.
- Removal and restoration through the Game's Trash system.

Their specialized properties and operations remain distinct.