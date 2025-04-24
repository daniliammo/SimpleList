# Simple List (Vala)

## RU-README(Current), [RU-README](https://github.com/daniliammo/SimpleList/blob/master/RU-README.md)

## Why?
* Created because `Gee.Array` consumes too much memory and may have memory leaks.

## Goals
* Implement a simple, fast, and memory-efficient list.
* Fully implemented in Vala language.

## List Implementations
* `LazyCompactingList`
    - Indexes are always valid.
    - If an element is removed from the end of the list, it resizes the array and removes the `null`.
    - If an element is removed from the middle of the list, it's marked as `null` and the array isn't recreated.
        * If other `null` elements reach this position (not at the end), the array will be resized and all will be removed.
    - Element removal is faster than `ActiveCompactingList`, but consumes more memory.

* `ActiveCompactingList`
    - Indexes aren't always valid.
    - If any element is removed (even from the middle), it recreates the array without that element.
    - Element removal is slightly slower than `LazyCompactingList`, but consumes less memory.

## Usage Example
* Usage examples can be found in the `example` directory.
* Building examples:
    - Follow the instructions in the 'Building the Project' section.
        * The executable will appear in `build/example`.

## Limitations
* `foreach` limitations:
    - Don't use `foreach` with `non-nullable` types (e.g., `int`, `uint`)
        * Safe for `foreach`: `LazyCompactingList<int?>` or `ActiveCompactingList<int?>` 
        * Unsafe for `foreach`: `LazyCompactingList<int>` or `ActiveCompactingList<int>` 

## Building the Project
* Configure the project. Run `meson build`
    - Go to the `build` directory. Run `cd build`
    - Build the project. Run `ninja` or `ninja install` if you want to install the library.
    - `libSimpleList.so`, `SimpleList.h`, and `SimpleList.vapi` will appear in `build/src`