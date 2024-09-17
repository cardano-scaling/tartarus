![](/assets/tartarus.jpeg)

> In Greek mythology, Tartarus (/ˈtɑːrtərəs/; Ancient Greek: Τάρταρος, romanized: Tártaros)[1] is the deep abyss that is used as a dungeon of torment and suffering for the wicked and as the prison for the Titans.

[Wikipedia](https://en.wikipedia.org/wiki/Tartarus)

# What is Tartarus?

_Tartarus_ is an adversarial Cardano network infrastructure project. It aims at providing necessary tools to run Cardano nodes interconnected through a network that predictably _misbehaves_ in various weird, but realistic, ways, in order to allow the Cardano technical community to test nodes, dApps, services, in as close to real life conditions as possible.

The goal is to maintain some infrastructure, e.g specialised networking, log capture and analysis, centralised logic to simulate coordinated attacks, etc. leveraging existing tools as much as possible, where:

* Adversarial scenarios are run with a fixed and known schedule,
* Monitoring is provided in real time, publicly,
* New scenarios can be easily proposed, discussed, and plugged in,
* Anyone can join with minimal modification to stock software.


# Who can benefit from _Tartarus_?

* Infrastructure developers who want to explore how their code behaves in a controlled adversarial environment,
* Researchers who want to gather actual data on large scale attacks or test new ideas,
* dApp developers who need strong guarantees their application won't misbehave in the face of adversarial conditions,
* Potential Cardano adopters, who will be provided with concrete evidences on the security of the network.

# Current status

_Tartarus_ is barely nascent and not ready for prime-time and general availability yet.

# Resources

* [cardano-playground](https://github.com/input-output-hk/cardano-playground/tree/ccf85e6e8da7c83f2b6d48e0b484bb3271b84c71/docs/explain) specific explanations on how to spin up a whole network using this particular Nix infrastructure, on AWS cluster(s)
