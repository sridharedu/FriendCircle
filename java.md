Here is the focused view of the **"Key Practical Terms (Step-by-Step)"** for each technology — starting from the first step and going deeper step-by-step. Each step includes important annotations, keywords, APIs, or patterns commonly used in real implementations.

> 💡 **Hint**: Each term listed below is a practical hook — either a key annotation, API call, or config keyword — that you will frequently use when working with the technology. These are not theoretical; they are meant to help you recall "what to use where" in code, configs, or during debugging. Think of them as building blocks in order of how you'd apply them.

---

## 🧠 Java Cheat Sheet — Core Language Essentials (Java 8/11/17)

This cheat sheet covers **key Java language features** across Java 8 to Java 17. These are **must-memorize**, high-frequency terms that frequently show up in real-world code, interviews, and clean architecture patterns.

### 🔹 Key Syntax Constructs

* `var` → Local variable type inference (Java 10+)
* `record` → Lightweight immutable data carrier (Java 14+)
* `sealed`, `permits` → Restricted inheritance (Java 17)

### 🔹 Functional Interfaces & Lambdas

* `Function<T, R>`, `Predicate<T>`, `Consumer<T>`, `Supplier<T>`
* Lambda syntax: `(a, b) -> a + b`
* Method reference: `System.out::println`, `String::toUpperCase`

### 🔹 Stream API (Java 8+)

* Stream creation:

    * `Stream.of(1, 2, 3)`
    * `list.stream()`
* Transformation:

    * `.map()`, `.filter()`, `.flatMap()`
* Terminal operations:

    * `.collect(Collectors.toList())`
    * `.forEach(System.out::println)`
    * `.count()`, `.reduce()`

### 🔹 Collectors

* `Collectors.toList()`, `toSet()`, `toMap()`
* `Collectors.groupingBy(...)` → Create maps of grouped data
* `Collectors.partitioningBy(...)` → Boolean split

### 🔹 Optional API

* `Optional.of()`, `Optional.empty()`
* `.orElse()`, `.orElseGet()`, `.orElseThrow()`
* `.map()`, `.flatMap()` for transforming inside Optional

### 🔹 Enhancements & Utility

* `Comparator.comparing(...)` for sorting
* `List.copyOf(...)` → Immutable list (Java 10+)
* `Objects.requireNonNull(...)`
* `String.join(...)`, `String.repeat(...)`
* `Files.readString(path)`, `Path.of(...)` (Java 11)

### 🔹 Pattern Matching & instanceof

* `if (obj instanceof String s)` → Smart casting (Java 16+)

### 🔹 Common APIs You Should Know By Heart

* `java.lang.String`
* `java.util.List`, `ArrayList`, `LinkedList`
* `java.util.Map`, `HashMap`, `LinkedHashMap`
* `java.util.Set`, `HashSet`, `TreeSet`
* `java.util.Optional`
* `java.time.LocalDate`, `LocalDateTime`, `Duration`
* `java.util.function.*`
* `java.util.stream.*`

### 🔹 Important Keywords

* `static`, `final`, `this`, `super`
* `synchronized`, `volatile`
* `transient`, `default` (in interfaces)

### 🔹 Exception Handling

* `try`, `catch`, `finally`
* `try-with-resources` (implements `AutoCloseable`)
* `throw new`, `throws`

---

Let me know when you want the **next Cheat Sheet (e.g., CompletableFuture)**.
