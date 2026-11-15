# Architecture guide

This guide provides an overview of the system's architecture, including the
4+1 architectural view model and the architecture decision records (ADRs) used
to document architectural decisions.

It will not keep implementation details such as code examples or specific
implementation choices.

## Architecture models

We describe our software in the 4+1 architectural view model. Each view not only
caters to specific stakeholder concerns but also employs different modeling
techniques to ensure that every aspect of the system is thoroughly documented
and communicated.

<!-- Please only keep subsections, if they are relevant to the project and
support the understanding of the system's architecture -->

### Logical view

This view focuses on the system's functionality by describing the key
abstractions, components, and their relationships that deliver the business
requirements.

<!-- Please add either:
- UML Class Diagrams: Represent classes and relationships.
- Object Diagrams: Show instances and their connections.
- Data Flow Diagrams (DFDs): Sometimes used to depict data movements.
-->

### Development view

This view lays out the static structure of the software in terms of modules,
packages, or components as organized within the codebase. It focuses on
maintainability, reuse, and how teams collaborate on the project.

<!-- Please add either:
- UML Component Diagrams: Depict the organization of software components.
- Package Diagrams: Show the structure of code organization.
- Module Dependency Graphs: Visualize how modules depend on one another.
-->

### Process view

This view captures the dynamic behavior of the system at runtime. It shows how
different processes or threads interact, manage concurrency, and handle
communication.

<!-- Please add either:
- Sequence Diagrams: Show the flow of messages between processes.
- Activity Diagrams: Visualize the flow of control within a process.
- State Machine Diagrams: Model the state transitions of a process.
-->

### Physical view

This view maps the software components onto the hardware infrastructure. It
details how the system will be deployed across servers, networks, and other
physical resources.

<!-- Please add either:
- UML Deployment Diagrams: Show the physical layout of components.
- Network Diagrams: Provide details on connectivity and infrastructure.
- Infrastructure Diagrams: Visualize the physical infrastructure.
-->

## Architecture Decision Records (ADRs)

For bigger projects, we use Architecture Decision Records (ADRs) to document
architectural decisions and their rationale. ADRs are stored in the `docs/adr`
directory.
