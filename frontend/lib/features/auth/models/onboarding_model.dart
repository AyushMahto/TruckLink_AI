class OnboardingModel {
  final String title;
  final String description;
  final String image;

  const OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

const onboardingData = [
  OnboardingModel(
    title: "Book Trucks in Seconds",
    description:
        "Find verified trucks instantly for local and long-distance transportation.",
    image: "",
  ),
  OnboardingModel(
    title: "Track Live Location",
    description:
        "Monitor your shipment in real time with accurate GPS tracking.",
    image: "",
  ),
  OnboardingModel(
    title: "AI Powered Logistics",
    description:
        "Smart pricing, route optimization and AI recommendations for every booking.",
    image: "",
  ),
];
