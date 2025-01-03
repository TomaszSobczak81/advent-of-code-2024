# [Advent of Code 2024](https://adventofcode.com/2024)

## Usage

To make it simply to use for everyone without needs to install any dependencies this repo is prepared to test everything with docker container.

* Run `make build` to build docker image with correct user permissions
* Run `make up` to start docker container
* Run `make ssh` to exec into container and run solutions

## Solutions

* Run `make run_day_00` to solve Day 0 solutions (Repository init)
* Run `make run_day_01` to solve Day 1 solutions [Historian Hysteria](https://adventofcode.com/2024/day/1)
* Run `make run_day_02` to solve Day 2 solutions [Red-Nosed Reports](https://adventofcode.com/2024/day/2)
* Run `make run_day_03` to solve Day 3 solutions [Mull It Over](https://adventofcode.com/2024/day/3)
* Run `make run_day_04` to solve Day 4 solutions [Ceres Search](https://adventofcode.com/2024/day/4)
* Run `make run_day_05` to solve Day 5 solutions [Print Queue](https://adventofcode.com/2024/day/5)
* Run `make run_day_06` to solve Day 6 solutions [Guard Gallivant](https://adventofcode.com/2024/day/6)
* Run `make run_day_07` to solve Day 6 solutions [Bridge Repair](https://adventofcode.com/2024/day/7)
* Run `make run_day_08` to solve Day 8 solutions [Resonant Collinearity](https://adventofcode.com/2024/day/8)
* Run `make run_day_09` to solve Day 9 solutions [Disk Fragmenter](https://adventofcode.com/2024/day/9)
* Run `make run_day_10` to solve Day 10 solutions [Hoof It](https://adventofcode.com/2024/day/10)
* Run `make run_day_11` to solve Day 11 solutions [Plutonian Pebbles](https://adventofcode.com/2024/day/11)
* Run `make run_day_12` to solve Day 12 solutions [Garden Groups](https://adventofcode.com/2024/day/12)
* Run `make run_day_13` to solve Day 13 solutions [Claw Contraption](https://adventofcode.com/2024/day/13)
* Run `make run_day_14` to solve Day 14 solutions [Restroom Redoubt](https://adventofcode.com/2024/day/14)
* Run `make run_day_15` to solve Day 15 solutions [Warehouse Woes](https://adventofcode.com/2024/day/15)
* Run `make run_day_16` to solve Day 16 solutions [Reindeer Maze](https://adventofcode.com/2024/day/16)
* Run `make run_day_17` to solve Day 17 solutions [Chronospatial Computer](https://adventofcode.com/2024/day/17)
* Run `make run_day_18` to solve Day 18 solutions [RAM Run](https://adventofcode.com/2024/day/18)

## TODO

* [ ] Day 7 part 2 needs to be optimized
```
docker compose exec console ruby ./src/aoc.rb day07
Test passed for part one. Got 3749 as expected.
Solution for part one: 2941973819040 took 449.1696079967369 ms.
Test passed for part two. Got 11387 as expected.
Solution for part two: 249943041417600 took 16830.26892899943 ms.
```

* [ ] Day 9 needs to be optimized
```
docker compose exec console ruby ./src/aoc.rb day09
Test passed for part one. Got 1928 as expected.
Solution for part one: 6378826667552 took 68040.98141299983 ms.
Test passed for part two. Got 2858 as expected.
Solution for part two: 6413328569890 took 9574.002748999192 ms.
```

* [ ] Day 12 part 2 needs to be fixed as live results is wrong
* [ ] Day 13 part 2 needs to be solved and optimized
* [ ] Day 15 part 2 needs to be fixed as live results is wrong
* [ ] Day 16 part 1 needs to be solved and optimized
* [ ] Day 17 part 2 needs to be solved and optimized

* [ ] Day 18 part 2 needs to be optimized
```
docker compose exec console ruby ./src/aoc.rb day18
Test passed for part one. Got 22 as expected.
Solution for part one: 248 took 10.304374000043026 ms.
Test passed for part two. Got 6,1 as expected.
Solution for part two: 32,55 took 20221.42628599977 ms.
```
