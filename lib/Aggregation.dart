class Book {
  String title;

  Book(this.title);
}

class Library {
  List<Book> books = [];  // Library contains multiple Books

  void addBook(Book book) {
    books.add(book);
  }
}

// Usage
void main() {
  Library library = Library();
  Book book1 = Book("The God Father");
  library.addBook(book1);
  print(library.books[0].title);  // Output: The God Father
}