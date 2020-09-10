
# LiveView proposal

This is in relation to Josh's [notes and deck about Asclepius](https://docs.google.com/presentation/d/1yXd52f0c3nW9aIKxvyx7xzYZAZSsmbHzUHWn1ch_emo/edit#slide=id.g9641126799_0_172). Overall I agree with everything said so far, the centralised definitions of order journeys + products sounds like a great solution.

This is a specific idea about how we manage the user interaction with that central app. If we take the whole of of the Asclepius deck, I'm talking about point 2 from Slide 6:

> - Responding to API requests from public sites, performing any server-side validation required, and returning a suitable response, be that the contents of the next question/step, or a list of error messages if the submitted question(s) are invalid.

As context, I've been doing a decent amount of coding with Elixir & Phoenix over the last couple of years, on various personal projects. You might have heard of Phoenix LiveView which was introduced last year, and since then the results have been pretty interesting. In a nutshell, it allows you to rich fairly rich, interactive experiences using just server-side tech. No APIs, no react app needed, virtually no javascript. https://dockyard.com/blog/2018/12/12/phoenix-liveview-interactive-real-time-apps-no-need-to-write-javascript

## What

I'd like to discuss this _model_ as a potential solution for our checkout journeys. (Whilst Elixir is a very good fit for LiveView, it's also been implemented in various other stacks, including Rails via StimulusReflex)

## Why

I started thinking about this over the last month or two after seeing all the work that's currently going into building forms on SH24. I've built a couple of personal projects that use very similar forms: interactive questions, extra pop-ups, etc. in LiveView and it's been exceptionally easy, with little complexity.

Our checkout journeys are not particularly complicated applications, they are forms with some light interactivity. Whilst React is a good choice for this, it will also introduce a large amount of extra work - two different apps, an API, all the interchange between them, etc. I think that adopting a server-side model via something like LiveView could save us a lot of work and enable updates to be faster and simpler.

## Demo

I pulled out an example form from my other project, and put it up on Heroku to demonstrate.

https://secret-chamber-40890.herokuapp.com/


It's very simple, just a couple of fields with a conditional field, and validations. For this demo I haven't tried to do replicate any kind of smart field specification like Asclepius would do, I've just hard-coded some fields. You can see that validations are instant, questions can be hidden/shown, and plenty of other interaction is possible.

Here's the code for it, with a quick video walkthrough of the important bits. I haven't spent any time cleaning this up, so there is still boilerplate and other messy bits, but it should demonstrate the fundamentals.

https://github.com/alexslade/form-demo
[Walkthrough Video (2:40)](https://www.loom.com/share/53ce1fd54c2e4441a5bd50ae90f833b8)
