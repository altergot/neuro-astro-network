
# Neuro-astro network model

Here we propose a computational model of working memory (WM) implemented by the spiking neuron network (SNN) interacting with a network of astrocytes.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- MATLAB R2018b
- Statistics Toolbox
- Image Processing Toolbox
- The minimum required amount of RAM is 16 GB

### Installing

Clone repo:
```
git clone https://github.com/altergot/neuro-astro-network.git
```

### Run

To simulate experiment open and run main.m

Default experiment consist of 4 images at the learning stage (digits 0, 1, 2, 3):

![zero](/images/zero.jpg "Zero")
![one](/images/one.jpg "One")
![two](/images/two.jpg "Two")
![three](/images/three.jpg "Three")

And at the testing stage there are 8 images are presented (learned and new) in the fixed order: digits 0, 5, 1, 6, 2, 7, 3, 8.

![zero](/images/zero.jpg "Zero")
![five](/images/five.jpg "Five")
![one](/images/one.jpg "One")
![six](/images/six.jpg "Six")
![two](/images/two.jpg "Two")
![seven](/images/seven.jpg "Seven")
![three](/images/three.jpg "Three")
![eight](/images/five.jpg "Eight")

Simulation model time is 7 seconds and step is 0.0001 seconds.
Run time of the simulation for default parameters is around 3 hours.

There are multiple results of the simulation:


1. The movie of learning and testing processes

    ![response](/results/video_response_17026.png "Video frame 17026. Testing")

    Input signal, neuron spikes, astrocyte calcium concentration.

2. Neuron spike frequencies for recognized patterns

    <table>
        <tr>
            <td>
                <img src="/results/freq_response_0.png" alt="Neuron frequencies"/>
            </td>
            <td>
                <img src="/results/freq_response_1.png" alt="Neuron frequencies"/>
            </td>
            <td>
                <img src="/results/freq_response_2.png" alt="Neuron frequencies"/>
            </td>
            <td>
                <img src="/results/freq_response_3.png" alt="Neuron frequencies"/>
            </td>
        </tr>
    </table>

3. Binarized neuron frequencies for recognized patterns

    <table>
        <tr>
            <td>
                <img src="/results/thr_response_0.png" alt="Neuron frequencies binarized"/>
            </td>
            <td>
                <img src="/results/thr_response_1.png" alt="Neuron frequencies binarized"/>
            </td>
            <td>
                <img src="/results/thr_response_2.png" alt="Neuron frequencies binarized"/>
            </td>
            <td>
                <img src="/results/thr_response_3.png" alt="Neuron frequencies binarized"/>
            </td>
        </tr>
        <tr style="text-align: center;">
            <td>0.9157</td>
            <td>0.9407</td>
            <td>0.9092</td>
            <td>0.8774</td>
        </tr>
    </table>

4. The correlation of recalled pattern with ideal item for each image and its average value

    Correlation of recalled pattern for images (0,1,2,3): 0.9157, 0.9407, 0.9092, 0.8774
    
    Average correlation = 0.9108

### Parameters

File model_parameters.m consist of multiple blocks of parameters described in the paper:
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
- Memory performance

## Authors

* **Yulia Tsybina** - *Implementation* - [altergot](https://github.com/altergot)
* **Mikhail Krivonosov** - *Implementation* - [mike_live](https://github.com/mike_live)
* **Susan Gordleeva** - *Biological model constructing*
* **Alexander Gorban** - *Project vision*
* **Alexey Zaikin** - *Project vision*

## Cite

Formation of working memory in a spiking neuron network accompanied by astrocytes
Susanna Yu. Gordleeva, Yulia A. Tsybina, Mikhail I. Krivonosov, Mikhail V. Ivanchenko,
Alexey A. Zaikin, Victor B. Kazantsev, Alexander N. Gorban

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* We acknowledge the Ministry of Science and Higher Education agreement No. 075-15-2020-808
