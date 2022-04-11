class BoardingModel {
  final String logoImagePath;
  final String title;
  final String body;

  BoardingModel({
    required this.logoImagePath,
    required this.title,
    required this.body,
  });
}
List<BoardingModel> listOfBoardingItems = [
  BoardingModel(
    logoImagePath: 'assets/images/logo.svg',
    title: 'Screen Title 1',
    body: 'Screen Body 1',
  ),
  BoardingModel(
    logoImagePath: 'assets/images/logo.svg',
    title: 'Screen Title 2',
    body: 'Screen Body 2',
  ),
  BoardingModel(
    logoImagePath: 'assets/images/logo.svg',
    title: 'Get Started',
    body:
    'If you’re offered a seat on a rocket ship, don’t ask what seat! Just get on.',
  ),
];