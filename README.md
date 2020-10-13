
# Neuro-astro network model

Here we propose a computational model of working memory (WM) implemented by the spiking neuron network (SNN) interacting with a network of astrocytes.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- MATLAB R2018b
- Statistics Toolbox
- Image Processing Toolbox

### Installing

Clone repo:
```
git clone https://github.com/altergot/neuro-astro-network.git
```

### Run

To simulate experiment open and run main.m
Default experiment consist of 4 images at the learning stage (digits 0, 1, 2, 3):
![zero](/images/zero.png "Zero")
![one](/images/one.png "One")
![two](/images/two.png "Two")
![three](/images/three.png "Three")
At the testing stage there are 8 alternated images (learned and new): digits 0, 5, 1, 6, 2, 7, 3, 8.

### Parameters

File model_parameters.m consist of multiple blocks of parameters described in paper:
- Timeline
- Experiment
- Applied pattern current
- Movie
- Poisson noise
- Runge-Kutta steps
- Network size
- Initial conditions
- Neuron mode
- Synaptic connections
- Astrosyte model
- Image similarity

## Authors

* **Yulia Tsybina** - *Implementation* - [altergot](https://github.com/altergot)
* **Mikhail Krivonosov** - *Implementation* - [mike_live](https://github.com/mike_live)
* **Susan Gordleeva** - *Biological model constructing*
* **Alexander Gorban** - *Project vision*
* **Alexey Zaikin** - *Project vision*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* We acknowledge the Ministry of Science and Higher Education agreement No. 075-15-2020-808
