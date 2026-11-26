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

## Future System: Crafting

GRIMOIRE should eventually support a crafting system that allows Actors to produce Objects using reusable recipes stored in Collections.

This system is planned for a future implementation milestone.

### Crafting Libraries and Recipes

Recipes are stored in dedicated Collection libraries.

Examples of libraries:
- Potions
- Forge
- Cook
- Paint

Examples of recipes:
- Minor Potion.
- Iron Dagger.
- Cake.
- Simple Potion.

A recipe describes:
- Required materials and quantities.
- Required tools or facilities, when applicable.
- Default properties of the resulting Object.
- Crafting duration, if applicable.
- Optional skill checks or other requirements.

### Crafting Operations

Crafting is initiated through the `craft` command.

Proposed syntax:

`craft <library> <recipe> <character> [options]`

GRIMOIRE checks whether the Actor meets the recipe requirements and possesses the required materials.

When an operation successfully starts, its required materials are consumed and committed to that operation.

A Crafting Operation is an independent Game entity. It records:
- Unique operation identity.
- Recipe used.
- Actor performing the crafting.
- Consumed materials.
- Current status.
- Resulting Object, when completed.

Crafting may complete immediately or remain pending when time is required.

### Crafting Lifecycle

The proposed command structure includes:

**Start crafting**

`craft potions minor Sidabras s`

Example response:

`Crafting potions minor from Sidabras on standby as cs01.`

**List pending operations**

`craft standing`

Displays crafting operations currently awaiting completion.

**Complete crafting**

`craft end cs01`

Completes the operation and creates the resulting Object Instance using the recipe's default properties.

**Complete with customization**

`craft end cs01 c`

Completes the operation and opens the resulting Object Instance in edit mode.

This allows the GM to customize the result before accepting it into the Game.

For example, a particularly successful crafting roll might justify increasing the healing capacity of a potion.

Customization affects only the resulting Instance, never the original recipe.

**Fail crafting**

`craft fail cs01`

Marks the operation as failed.

Consumed materials are not automatically returned. Refunds, alternative results, and other consequences may eventually be configurable through recipes or rules.

### Separation of Responsibilities

The crafting system must distinguish three separate concepts:

- **Recipe:** Defines what can be crafted, its requirements, and its default result.
- **Crafting Operation:** Tracks an individual attempt to produce something.
- **Resulting Instance:** Represents the actual Object produced by the operation.

This separation allows multiple Actors to use the same recipe independently and permits multiple simultaneous crafting operations.

### Design Principles

- Crafting must use existing Inventory and Object systems.
- Required materials must be consumed when crafting successfully enters its pending state.
- Materials committed to one operation cannot be reused by another.
- Failed operations must not accidentally create their intended results.
- Customization must never modify the original recipe.
- Pending operations must belong to their respective Games.
- Crafting operations and their outcomes should be recorded in Game History.

## Actor Capabilities and Conversion

Actors share a common foundation but may possess different capabilities depending on how they are used within a Game.

GRIMOIRE should favor composition and optional capabilities over rigid inheritance between Actor types.

### Shared Actor Foundation

Every Actor has a common set of properties and behaviors.

These may include:
- Identity and descriptive information.
- Attributes and statistics.
- Hit points.
- Conditions and status effects.
- Abilities.
- Inventory.
- Resources.
- History and provenance.

Not every Actor needs to use every available capability.

### Optional Capabilities

An Actor may possess additional capabilities that enable specialized management.

For example, Character capabilities provide the properties needed to manage an Actor as a Player Character.

These may include:
- Class and subclass.
- Level and experience.
- Background.
- Proficiency.
- Character progression.

Other capabilities may be introduced in the future without requiring changes to the fundamental Actor structure.

### Actor Conversion

An existing Actor may acquire additional capabilities through conversion.

Proposed command:

`actor convert <actor>`

Conversion adds the necessary properties and structures without replacing existing information.

For example, converting a Goblin into a Player Character makes Character capabilities available while preserving its original identity and properties.

Unassigned properties remain empty or use appropriate default values.

Conversion must not automatically assign a class, level, background, or other character progression choices.

### Capability and Classification

GRIMOIRE must distinguish between an Actor's classification and its capabilities.

- **Classification** describes what the Actor is.
- **Capabilities** describe how the Actor can be managed and what additional functionality is available to it.

An Actor may retain its original classification while acquiring additional capabilities.

For example, a Goblin converted into a Player Character remains classified as a Goblin.

This distinction prevents conversion from unintentionally changing an Actor's identity.

### Preservation and Reversibility

Adding capabilities must never erase or invalidate existing Actor properties.

Conversion should be non-destructive.

If capability removal is introduced in the future, it must account for any data or dependencies created while that capability was active. Removing a capability must not silently destroy unrelated Actor information.