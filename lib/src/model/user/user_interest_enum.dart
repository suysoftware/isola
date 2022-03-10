// ignore: constant_identifier_names
enum UserInterest { Hiking, Reading, Art, Cooking }

logoGonder() {}

String interestText(UserInterest interest) {
  switch (interest) {
    case UserInterest.Art:
      {
        return ("Art");
      }

    case UserInterest.Cooking:
      {
        return ("Cooking");
      }

    case UserInterest.Hiking:
      {
        return ("Hiking");
      }

    case UserInterest.Reading:
      {
        return ("Reading");
      }
  }
}
