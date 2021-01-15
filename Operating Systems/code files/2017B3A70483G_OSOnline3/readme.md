*Working:*
Inputs were working well when signals were not sent.
Processes were being created properly.
Tossing was also working.

Currently compilation step itself is giving error :(

*Completed:*
All the signal handlings except inningsOver have been 
completed. No way to test this out though because it's 
not compiling. Team stats and all were generated using
shared memory arrays itself.
Scoreboard of umpire also.
Seeds were also properly allotted.

*Not Attempted:*
Innings over hasn't been attempted.
Killing and creation of processes when they got out
or were finishing their bowling overs was not attempted. 
Handled them using indices only.


The thing was,
how do I make the teams process to create the new process, when the signal was being handled in umpire.
Thought of creating it using a new signal to get to teams, but the doc didn't mention anything of that sort.