# star_burst

Star Burst pattern generator

The 'rules' for this pattern are basically:
* Pick the center points for multiple 'stars' (at least one to start; randomly add others as time goes on).
* For each 'star', draw multiple rings of radial lines around the star using various colors. (I use the same color for each 'level' of rings in sync with the other stars; but you could randomize it to not be in sync.)
* For each ring of radial lines, don't draw a line if it would cross another star's current outer most ring.
* For each ring of radial lines, don't draw a line if it is off the page.

## Installation

* Clone this repo.

```bash
cd some/path
git clone https://github.com/drhuffman12/star_burst
```

* Build an run (see examples under "doc/examples").

```
shards install
crystal build --release doc/examples/demo.cr
doc/examples/demo 100 100 8 12 4.0 1 doc/examples/a/
```

## Usage

### Examples

Below are some example sky 'seed' scripts, along with an example run's animated image.

```bash
doc/examples/a/run.sh
```
![doc/examples/a/sky_1/frames.gif](doc/examples/a/sky_1/frames.gif)

```bash
doc/examples/b/run.sh
```
![doc/examples/b/sky_1/frames.gif](doc/examples/b/sky_1/frames.gif)

```bash
doc/examples/c/run.sh
```
![doc/examples/c/sky_1/frames.gif](doc/examples/c/sky_1/frames.gif)

```bash
doc/examples/d/run.sh
```
![doc/examples/d/sky_1/frames.gif](doc/examples/d/sky_1/frames.gif)

```bash
doc/examples/e/run.sh
```
![doc/examples/e/sky_1/frames.gif](doc/examples/e/sky_1/frames.gif)
## Contributing

1. Fork it (<https://github.com/drhuffman12/star_burst/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [drhuffman12](https://github.com/drhuffman12) Daniel Huffman - creator, maintainer
