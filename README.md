Conway's Game of Life

WHY?
I've done gol a few times during code retreats but the code is always thrown away and the app is never finished.  I wanted to actually finish it for once.

It's straight ruby (I built it with 1.9.2-p290)
I started implementing an Opengl display but have never done openGl before so that's a WIP.
The code passes all tests and I think it's in pretty good shape as far as it following Conway's rules
but it isn't an elegant implementation by any means.

It was fun to build, took me longer to do than I had anticipated.  the hardest part was
having cells born if they have 3 live neighbors.

The work was done completely with TDD

The original spec called for an infinite playing field and my implementation supports that although the visual 
part (which isn't yet working) is on a finite playing field.  

I still need to add a seed process to populate the world prior to starting the clock ticking

to play it: 
ruby display.rb  (once the display stuff is fixed and working)

to run the tests: 
rspec tests.rb

