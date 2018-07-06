# star_burst

Star Burst pattern generator

The basic idea is to:
* Pick the center points for multiple 'stars'.
* For each 'star', draw multiple rings of radial lines around the star using various colors. (I use the same color for each 'level' of rings in sync with the other stars; but you could randomize it to not be in sync.)
* For each ring of radial lines, don't draw a line if it would cross another star's current outer most ring.
* For each ring of radial lines, don't draw a line if it is off the page.

## Usage

### Examples

```bash
doc/examples/a/run.sh
```
![doc/examples/a/_1_.gif](doc/examples/a/_1_.gif)

```bash
doc/examples/b/run.sh
```
![doc/examples/b/_1_.gif](doc/examples/b/_1_.gif)

```bash
doc/examples/c/run.sh
```
![doc/examples/c/_1_.gif](doc/examples/c/_1_.gif)

```bash
doc/examples/d/run.sh
```
![doc/examples/d/_1_.gif](doc/examples/d/_1_.gif)

```bash
doc/examples/e/run.sh
```
![doc/examples/e/_1_.gif](doc/examples/e/_1_.gif)

## Installation

TODO: Write installation instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/star_burst/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [your-github-user](https://github.com/your-github-user) Daniel Huffman - creator, maintainer
