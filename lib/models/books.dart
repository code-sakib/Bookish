import 'package:firebase_1/database/descriptions.dart';
import 'package:firebase_1/database/img_urls.dart';

class Books {
  late String category;
  late int numberOfBooks;
  late bool isActive;
  late Map<String, String> bookNameWithAuthor;
  late List<String> listOfImgUrls;
  late List<String> listOfDescriptions;

  Books.all()
      : category = 'All',
        isActive = false,
        listOfImgUrls = allImgLinks,
        listOfDescriptions = listOfAllDescriptions,
        //<NameOfBook, Author>
        bookNameWithAuthor = {
          'Think And grow rich': 'Napolean Hill',
          "Enrique's Journey": 'Sonia Nazario',
          "Frida: A Biography of Frida Kahlo": 'Hayden Herrera',
          "The Immortal Life of Henrietta Lacks": 'Rebecca Skloot',
          'Into the Wild': 'Jon Krakauer',
          'Let Us Now Praise Famous Men: Three Tenant Families': 'James Agee',
          'The Lost City of Z: A Tale of Deadly Obsession in the Amazon':
              'David Grann',
          'The Little Prince': 'Antoine de Saint-Exupery',
          'Siddhartha': 'Herman Hesse',
          'Candide': 'Voltaire',
          'DARKNESS AT NOON': 'Arthur Koestler',
          'SONS AND LOVERS': 'D.H. Lawrence',
          'THE GRAPES OF WRATH': 'John Steinbeck',
          'UNDER THE VOLCANO': 'Malcolm Lowry',
          'THE WAY OF ALL FLESH': 'Samuel Butler',
          '1984': 'George Orwell',
          'I, CLAUDIUS': 'Robert Graves',
          'TO THE LIGHTHOUSE': 'Virginia Woolf',
          'As a Man Thinketh': 'James Allen',
          "Man's searching for meaning": 'Viktor Frankl',
          'Elon Musk': 'Ashlee Vance',
          'Steve Jobs': 'Walter Isaacson',
          'Chicken Soup for Unsinkable soul': 'Jack Canfield',
          'Getting Things Done by': 'David Allen',
          'Do Epic Shit': 'Ankur Warikoo',
          '12 Rules For Life': 'Jordan Peterson',
          'The 48 Laws Of Power': 'Robert Greene',
          "The Courage To Be Disliked": 'Ichiro Kishimi & Fumitake Koga',
          'How To Stop Worrying And Start Living': 'Dale Carnegie',
          'Daring Greatly': 'Brene Brown',
          'Big Magic': 'Elizabeth Gilbert',
          'The Autobiography of a Yogi': 'Yogananda Paramahansa'
        } {
    numberOfBooks = bookNameWithAuthor.length;
  }

  Books.biography()
      : category = 'Biography',
        isActive = false,
        listOfImgUrls = biographyImgLinks,
        listOfDescriptions = listOfBiographiesDescriptions,
        bookNameWithAuthor = {
          'Steve Jobs': 'Walter Isaacson',
          'A Beautiful Mind': 'Sylvia Nasar',
          'Alexander Hamilton': 'Ron Chernow',
          "Barracoon: The Story of the Last 'Black Cargo'":
              'Zora Neale Hurston',
          'Churchill: A Life': 'Martin Gilbert',
          "E=mc²: A Biography of the World's Most Famous Equation":
              'David Bodanis',
          "Enrique's Journey": 'Sonia Nazario',
          "Frida: A Biography of Frida Kahlo": 'Hayden Herrera',
          "The Immortal Life of Henrietta Lacks": 'Rebecca Skloot',
          'Into the Wild': 'Jon Krakauer',
          'Let Us Now Praise Famous Men: Three Tenant Families': 'James Agee',
          'The Lost City of Z: A Tale of Deadly Obsession in the Amazon':
              'David Grann',
          'Mao: The Unknown Story': 'Jung Chang',
          "Mad Girl's Love Song: Sylvia Plath and Life Before Ted by Andrew Wilson":
              'Andrew Wilson',
          'The Minds of Billy Milligan': 'Daniel Keyes',
          'Napoleon: A Life': 'Andrew Roberts',
          'The Passage of Power: The Years of Lyndon Johnson IV':
              'Robert A. Caro',
          'Prince: A Private View': 'Afshin Shahidi',
          'Rosemary: The Hidden Kennedy Daughter': 'Kate Clifford Larson',
          'Shelley: The Pursuit': 'Richard Holmes'
        } {
    numberOfBooks = bookNameWithAuthor.length;
  }

  Books.fiction()
      : category = 'Fiction',
        isActive = false,
        listOfImgUrls = fictionImgLinks,
        listOfDescriptions = listOfFictionDescriptions,
        bookNameWithAuthor = {
          'The Maid': 'Nita Prose',
          'Olga Dies Dreaming': 'Xochitl Gonzalez',
          "The Harry Potter And the Philosopher's stone": 'J.K.Rowling',
          "The Lord of the Rings Trilogy": 'J.R.R. Tolkien',
          'The Count of Monte Cristo': 'Alexandre Dumas',
          'To Kill a Mockingbird': 'Harper Lee',
          'The Little Prince': 'Antoine de Saint-Exupery',
          'Siddhartha': 'Herman Hesse',
          'Candide': 'Voltaire',
          'The Girl with the Dragon Tattoo': ' Stieg Larsson',
          'The Alchemist': 'Paulo Coelho'
        } {
    numberOfBooks = bookNameWithAuthor.length;
  }

  Books.nonFiction()
      : category = 'Non Fiction',
        isActive = false,
        listOfImgUrls = nonFictionImgLinks,
        listOfDescriptions = listOfNonFictionDescriptions,
        bookNameWithAuthor = {
          'Shoe-dog ': 'Phil knight',
          'We Should All Be Feminists': 'Chimamanda Ngozi Adichie',
          'A Short History of Nearly Everything': 'Bill Bryson',
          'Why I am an atheist':
              'Bhagat Singh',
          'A Promised Land': 'Barack Obama',
          'The Self-Care Project': 'Jayne Hardy',
          'Sapiens': 'Yuval Noah',
          'Paradox': 'Jim-Al-khalili',
          "A Room of One's Own by Virginia Woolf": 'unknown',
          'When Breath Becomes Air': 'American Neurosurgeon Dr. Paul Kalanithi',
          'The Autobiography of Malcolm X': 'Alex Haley and Malcolm X',
          'In Cold Blood': "Truman Capote",
        } {
    numberOfBooks = bookNameWithAuthor.length;
  }

  Books.novel()
      : category = 'Novel',
        isActive = false,
        listOfImgUrls = novelsImgLinks,
        listOfDescriptions = listOfNovelsDescriptions,
        bookNameWithAuthor = {
          'ULYSSES': 'James Joyce',
          'THE GREAT GATSBY': 'F. Scott Fitzgerald',
          'A PORTRAIT OF THE ARTIST AS A YOUNG MAN': 'James Joyce',
          'LOLITA': 'Vladimir Nabokov',
          'BRAVE NEW WORLD': 'Aldous Huxley',
          'THE SOUND AND THE FURY': 'William Faulkner',
          'CATCH-22': 'Joseph Heller',
          'DARKNESS AT NOON': 'Arthur Koestler',
          'SONS AND LOVERS': 'D.H. Lawrence',
          'THE GRAPES OF WRATH': 'John Steinbeck',
          'UNDER THE VOLCANO': 'Malcolm Lowry',
          'THE WAY OF ALL FLESH': 'Samuel Butler',
          '1984': 'George Orwell',
          'I, CLAUDIUS': 'Robert Graves',
          'TO THE LIGHTHOUSE': 'Virginia Woolf',
          'AN AMERICAN TRAGEDY': 'Theodore Dreiser',
          'THE HEART IS A LONELY HUNTER': 'Carson McCullers',
          'SLAUGHTERHOUSE-FIVE': ' Kurt Vonnegut',
          'INVISIBLE MAN': ' Ralph Ellison',
          'NATIVE SON': 'Richard Wright',
        } {
    numberOfBooks = bookNameWithAuthor.length;
  }

  Books.selfHelp()
      : category = 'Self Help',
        isActive = false,
        listOfImgUrls = selfHelpImgLinks,
        listOfDescriptions = listOfSelfHelpDescriptions,
        bookNameWithAuthor = {
          'Think And grow rich': 'Napolean Hill',
          'Rich Dad Poor Dad': 'Robert Kiyosaki',
          'Ikigia': 'Francesc Miralles',
          'Atomic Habits': 'James Clear',
          'As a Man Thinketh': 'James Allen',
          "Man's searching for meaning": 'Viktor Frankl',
          'Elon Musk': 'Ashlee Vance',
          'Steve Jobs': 'Walter Isaacson',
          'Chicken Soup for Unsinkable soul': 'Jack Canfield',
          'Getting Things Done by': 'David Allen',
          'Do Epic Shit': 'Ankur Warikoo',
          '12 Rules For Life': 'Jordan Peterson',
          'The 48 Laws Of Power': 'Robert Greene',
          "The Courage To Be Disliked": 'Ichiro Kishimi & Fumitake Koga',
          'How To Stop Worrying And Start Living': 'Dale Carnegie',
          'Daring Greatly': 'Brene Brown',
          'Big Magic': 'Elizabeth Gilbert',
          'Quiet': 'Susan Cain',
          'The Magic Of Thinking Big': 'David Joseph Schwartz',
          'The 5 Love Languages': 'Gary Chapman',
          'The Autobiography of a Yogi': 'Yogananda Paramahansa'
        } {
    numberOfBooks = bookNameWithAuthor.length;
  }
}
