

export function getTarget(seed) {
    return allTargets[seed % (allTargets.length + 1)];
}

const allTargets = [
    { "character": "Saitama", "hint": "A hero who doesn't find fights challenging." },
    { "character": "Albert Einstein", "hint": "Known for a theory involving light and speed." },
    { "character": "Marie Curie", "hint": "Pioneered research in radioactivity." },
    { "character": "Abraham Lincoln", "hint": "Famous for a tall hat and a significant address." },
    { "character": "Leonardo da Vinci", "hint": "Renaissance artist and inventor." },
    { "character": "Sherlock Holmes", "hint": "Lives on Baker Street." },
    { "character": "Harry Potter", "hint": "A wizard with a famous scar." },
    { "character": "Darth Vader", "hint": "He has a problematic relationship with his son." },
    { "character": "Batman", "hint": "He works at night and punish vilains." },
    { "character": "Spider-Man", "hint": "He received his abilities from an animal" },
    { "character": "Luke Skywalker", "hint": "A young hero with a special sword." },
    { "character": "James Bond", "hint": "A nicely suited British" },
    { "character": "Wonder Woman", "hint": "An Amazonian with a lasso." },
    { "character": "Superman", "hint": "An alien who works as a journalist." },
    { "character": "Pikachu", "hint": "A yellow creature" },
    { "character": "Hermione Granger", "hint": "A studious young witch." },
    { "character": "Tony Stark", "hint": "A billionaire with a powerful suit." },
    { "character": "Yoda", "hint": "A small but wise mentor." },
    { "character": "Katniss Everdeen", "hint": "A skilled archer from a dystopian future." },
    { "character": "Mario", "hint": "A plumber who often helps a woman." },
    { "character": "Gandalf", "hint": "A wizard with a long beard." },
    { "character": "Indiana Jones", "hint": "An archaeologist with an uncanny weapon." },
    { "character": "Black Panther", "hint": "A king with a suit made of a rare metal." },
    { "character": "Wolverine", "hint": "He hides his weapon in his body" },
    { "character": "Goku", "hint": "A warrior with a monkey tail." },
    { "character": "Lara Croft", "hint": "An adventurer often found in ancient ruins." },
    { "character": "Homer Simpson", "hint": "he works at a nuclear plant." },
    { "character": "Captain Jack Sparrow", "hint": "A pirate with a penchant for rum and mischief." },
    { "character": "The Joker", "hint": "A villain with a permanent grin." },
    { "character": "Luffy", "hint": "He dreams of finding the ultimate treasure." }
];

// "Martin Luther King Jr.",
// "Cleopatra",
// "Napoleon Bonaparte",
// "Mahatma Gandhi",
// "Mother Teresa",

// "Mickey Mouse",

// "Frodo Baggins",

// "Optimus Prime",

// "Bugs Bunny",

// "Winston Churchill",