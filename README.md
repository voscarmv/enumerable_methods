# Enumerable methods written purely in Ruby

> A replication of the original Enumerable methods #each, #each_with_index, #select, #all?, #none?, #count, #map and #inject using only Ruby.

![image](https://user-images.githubusercontent.com/2739245/90689036-026c0880-e235-11ea-9ab8-fb3adba9042f.png)

![image](https://user-images.githubusercontent.com/2739245/90690259-013bdb00-e237-11ea-8052-5aeb13405688.png)

The [`enumerable_spec.rb`](https://github.com/voscarmv/enumerable_methods/blob/master/spec/enumerable_spec.rb) tests use [an original output redirection method](https://github.com/voscarmv/enumerable_methods/blob/master/spec/enumerable_spec.rb#L4) to easily test `stdout` as well as `return` values from the functions.

## Built With

- Ruby
- Rubocop

## Live Demo

[Live Demo Link](https://repl.it/@OscarMier/enumerablemethods)


## Getting Started

**Run in bash. Make sure you have irb installed**

```
$ sudo apt install irb
$ ./main.sh
```

## Author

**Oscar Mier**
- Github: [@voscarmv](https://github.com/voscarmv)
- Twitter: [@voscarmv](https://twitter.com/voscarmv)
- Linkedin: [Oscar Mier](https://www.linkedin.com/in/oscar-mier-072984196/) 

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Thanks to [microverse](www.microverse.org)
- Thanks to The Odin Project for the fun exercise
- I used the documentation at [ruby-doc.org](https://ruby-doc.org/core-2.7.0/Enumerable.html#method-i-inject) to replicate the methods.

## 📝 License

This project is MIT licensed.
