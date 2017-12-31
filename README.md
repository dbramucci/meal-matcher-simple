# meal-matcher-simple

# Problem
## Story
You and your group of friends are on a trip and wish to go out for lunch. The
group needs to be safe and thus must follow the buddy system. Thus, for lunch,
if someone wants to go to a restaurant they will need to go in a group with at
least 2 people. There isn't enough time for anybody to go to more than one
restaurant so each person can only go to one restaurant.

Everyone writes downs their name and a list of restaurants that they are happy
to go to. Your job is to write a program that can make as many people happy as
possible by letting them go to one of the restaurants they listed but remember
that people aren't allowed to go by themselves for lunch and they want to go
to a restaurant they like. There can be multiple solutions, you only need to
return one.

## Core
Given a list of people where each person has a list of restaurants they are happy
to go to, find a plan showing what people should go to what restaurants so that
no person goes to a restaurant by themselves and as many people can go to a
restaurant they like. If a person cannot go to a restaurant they like, then they
shouldn't go to any restaurant. Some problems will have multiple solutions,
you only have to choose one.

## Bullet points
* Given
  * A list of people
  * For each person, the restaurants they like
* Find
  * For each restaurant that has people going
    * The list of people going to said restaurant
  * If a restaurant has only one person going, that one person should be removed
      as it is unsafe for them to travel alone.
  * If a restaurant has nobody attending it, it doesn't need to be listed
  * Not all solutions must be listed but any solution should have the maximum
      number of happy people possible.

## Examples
### Format

Problem
* Person
  * Restaurants liked
* Person
  * Restaurants liked

Solutions
* Solution 1
  * Restaurant
    * People going to restaurant
  * Restaurant
    * People going to restaurant
* Solution 2
  * Restaurant
    * People going to restaurant
  * Restaurant
    * People going to restaurant

### Example 1
Problem
* Alice
  * Taco Bell
* Bob
  * Taco Bell, Burger King

Solutions
* Solution 1
  * Taco Bell
    * Alice, Bob

### Example 2
Problem
* Alice
  * Taco Bell
* Bob
  * Taco Bell, Burger King
* Charlie
  * Burger King

Solutions
* Solution 1
  * Taco Bell
    * Alice, Bob
* Solution 2
  * Burger King
    * Bob, Charlie

### Example 3
Problem
* Adam
  * McDonalds
* Bruce
  * McDonalds, Taco Bell
* Catherine
  * Taco Bell
* Ellis
  * Taco Bell, Long John Silvers
* Ferris
  * Long John Silvers
* Geralt
  * Long John Silvers

Solutions
* Solution 1
  * Long John Silvers
    * Ferris, Geralt
  * McDonalds
    * Adam, Bruce
  * Taco Bell
    * Catherine, Ellis

# Using the provided executable
The provided executable is to be run from the command line.
Type the number of people in first and hit enter.
Then for each person, type their name, `:` and a comma separated list of
restaurants they would like to attend, hitting enter between people.

```
>>./meal-matcher-simple.exe
<number of people>
<name>: <rest1>, <rest2>, <rest3>, <restn>
<name>: <rest1>, <rest2>, <rest3>, <restn>
```

Example
```

>>./meal-matcher-simple.exe
>>6
>>Adam: McDonalds
>>Bruce: McDonalds, Taco Bell
>>Catherine: Taco Bell
>>Ellis: Taco Bell, Long John Silvers
>>Ferris: Long John Silvers
>>Geralt: Long John Slivers
Solution:
Long John Silvers: Ellis, Ferris
Taco Bell: Bruce, Catherine
Solution:
Long John Silvers: Ellis, Ferris
McDonalds: Adam, Bruce
Solution:
McDonalds: Adam, Bruce
Taco Bell: Catherine, Ellis
```
