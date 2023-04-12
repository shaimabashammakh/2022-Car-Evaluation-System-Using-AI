%Group 1
% Lujain Alsefri
% Sara Alahmari
% Shaikah Alroubaian
% Shaima Bashammakh
% ---------------------------------Start main method------------------------------------------

implement main
    open core

%-----------------------------------Domain Section -----------------------------------------
domains
%types of the variables
%string variable to store the finalResult evaluation
    eval = string.
    %variable for all the features of our system
    features =
        own_a_car; travel_time; travel_route; four_wheel; manual_gear; cylinder; fuel_economy; maintenance; safety; seats_comfortable; fridge; automatic_gear.
    %variable for the type of the questions of our system
    question = symbol.

%--------------------------------------Facts--------------------------------------------
class facts
%general form of the facts in our system : Yes and No answer.
    y_ans : (features).
    n_ans : (features).
%-------------------------------------Predicates----------------------------------------

class predicates
%the general form of all rule in our system
    finalResult : ().
    loop : ().
    evaluation : (eval) nondeterm anyflow.
    test : (question, features) determ.
    check : (question, features) determ.
    input : (features) determ.
    savedAnswer : (features, string) determ.
    clearYes : ().
    clearNo : ().
%--------------------------------------Clauses------------------------------------------

clauses
%run procedure to excute the queries
    run() :-
        % printing to the user the first messages
        console::init(),
        stdIo::write("\n----------------------------------------------------"),
        stdIo::write("\nWelcome to 'Car to Travel' Evaluation System!"),
        stdIo::write("\n----------------------------------------------------"),
        stdIo::write("\nPlease answer the following questions with yes or no (y/n).\n"),
        loop().
%-----------------------------------------------------------------------------------------
%procedure like loop to ask if the user want to use the system again
    loop() :-
        finalResult(),
        stdIo::write("\n "),
        stdIo::write("\n   Do you want to use the car evaluation system again?"),
        Ans = stdio::readLine(),
        Ans >< "n",
        !,
        clearYes(),
        clearNo(),
        loop().

%-----------------------------------------------------------------------------------------
%printing the end message to the user
    loop() :-
        stdIo::write("\n   *** Thank you for using our system *** \n").
%-----------------------------------------------------------------------------------------
%printing the evaluation according to the user input
    finalResult() :-
        evaluation(Eval),
        !,
        stdIo::write("\n", Eval).
%-----------------------------------------------------------------------------------------
%Rule1: the user does not own any car or does not use any car
    finalResult() :-
        stdIo::write("\n   Sorry, the system can't help you.").
        %**********************************
        % check the users answer then ask the user the next question
    check(_, Features) :-
        y_ans(Features),
        !.

    check(Question, Features) :-
        not(n_ans(Features)),
        test(Question, Features).

%asking the user the next question
    test(Question, Features) :-
        stdIo::write(Question),
        Ans = stdio::readLine(),
        savedAnswer(Features, Ans),
        Ans = "y".

%save user's answer
    savedAnswer(Features, "y") :-
        asserta(y_ans(Features)).
    savedAnswer(Features, "n") :-
        asserta(n_ans(Features)).

%clear all answers from the database to take the answers for the questions again
    clearYes() :-
        retract(y_ans(_)),
        fail.
    clearYes().
    clearNo() :-
        retract(n_ans(_)),
        fail.
    clearNo().

%-----------------------------------------------------------------------------------------
%the questions list
%************************Q1************************
    input(own_a_car) :-
        check("\n  Q: Have you used any car before? or do you own any car ?", own_a_car).

%************************Q2************************
    input(travel_time) :-
        check("\n  Q: Is the travel time more than 6-8 hours ?", travel_time).

%************************Q3************************
    input(travel_route) :-
        check("\n  Q: Does the travel route contains slopes or rough terrain ?", travel_route).

%************************Q4************************
    input(four_wheel) :-
        check("\n  Q: Does the car has four-wheel drive ?", four_wheel).

%************************Q5************************
    input(manual_gear) :-
        check("\n  Q: Does the car has manual gear ? ", manual_gear).

%************************Q6************************
    input(cylinder) :-
        check("\n  Q: Does the car has more than or equal 6 cylinders?", cylinder).

%************************Q7************************
    input(fuel_economy) :-
        check("\n  Q: Does the car has a fuel economy system? ", fuel_economy).

%************************Q8************************
    input(maintenance) :-
        check("\n  Q: Did you check the air pressure of the wheels and did you do maintenance for the car in the last 48 hours? ", maintenance).

%************************Q9************************
    input(safety) :-
        check("\n  Q: Does the car has a safety system ?", safety).

%************************Q10************************
    input(seats_comfortable) :-
        check("\n  Q: Are the seats comfortable?", seats_comfortable).

%************************Q11************************
    input(fridge) :-
        check("\n  Q: Does the car has a fridge ?", fridge).

%************************Q12************************
    input(automatic_gear) :-
        check("\n  Q: Does the car has an automatic gear ?", automatic_gear).

%-------------------------------------------END OF QUESTIONS ---------------------------------------
%--------------------------------------------The Evaluation--------------------------------------------
% Evaluation 1 :Own or use a car + Travel time > 6-8 hours + there are slopes or rough terrain -----
%----------------------------------------START OF RULES--------------------------------------------------
%--------------------------------------------Rule2--------------------------------------------
    evaluation("   The Evaluation: Your car is a bad option for travel, not suitable for slopes and rough terrain. ") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        not(input(four_wheel)).

%--------------------------------------------Rule3--------------------------------------------
    evaluation("   The Evaluation: Your car is not a very bad option, but it is difficult to control. ") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        not(input(manual_gear)).

%--------------------------------------------Rule4--------------------------------------------
    evaluation("   The Evaluation: Your car is not practical for travel, preferably cylinder more than or equal 6. ") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        input(manual_gear),
        not(input(cylinder)).

%--------------------------------------------Rule5--------------------------------------------
    evaluation("   The Evaluation: Your car may be impractical to travel for long distances because it does not save the fuel. ") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        input(manual_gear),
        input(cylinder),
        not(input(fuel_economy)).

%--------------------------------------------Rule6--------------------------------------------
    evaluation("   The Evaluation: Your car is not suitable, it was not well prepared for travel ") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        input(manual_gear),
        input(cylinder),
        input(fuel_economy),
        not(input(maintenance)).

%--------------------------------------------Rule7--------------------------------------------
    evaluation("   The Evaluation: Your car is a bad and unacceptable option for travel, having a safety system is very important") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        input(manual_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        not(input(safety)).

%--------------------------------------------Rule8--------------------------------------------
    evaluation("   The Evaluation: Your car as performance and as a driving is suitable, but travelling in this car can be tiring because the seats are not comfortable.") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        input(manual_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        input(safety),
        not(input(seats_comfortable)).

%--------------------------------------------Rule9--------------------------------------------
    evaluation("   The Evaluation: Your car is an acceptable option for travel, no having a fridge does make it unsuitable car. ") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        input(manual_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        input(safety),
        input(seats_comfortable),
        not(input(fridge)).

%--------------------------------------------Rule10--------------------------------------------
    evaluation("   The Evaluation: Your car is a perfect and suitable car for travel for more than 6-8 hours ") :-
        input(own_a_car),
        input(travel_time),
        input(travel_route),
        input(four_wheel),
        input(manual_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        input(safety),
        input(seats_comfortable),
        input(fridge).
%***************************END OF EVALUATION 1*************************************

% Evaluation 2 : Own or use a car + Travel time > 6-8 hours + No slopes or rough terrain ----
%--------------------------------------------Rule11--------------------------------------------
    evaluation("   The Evaluation: Your car is an acceptable option for travel, but it is better if the gear’s car is automatic") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        not(input(automatic_gear)).

%--------------------------------------------Rule12--------------------------------------------
    evaluation("   The Evaluation: Your car is not practical for travel, preferably cylinder more than or equal 6") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        input(automatic_gear),
        not(input(cylinder)).

%--------------------------------------------Rule13--------------------------------------------
    evaluation("   The Evaluation: Your car may be impractical to travel for long distances because it does not save the fuel. ") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        input(automatic_gear),
        input(cylinder),
        not(input(fuel_economy)).

%--------------------------------------------Rule14--------------------------------------------
    evaluation("   The Evaluation: Your car is not suitable, it was not well prepared for travel. ") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        input(automatic_gear),
        input(cylinder),
        input(fuel_economy),
        not(input(maintenance)).

%--------------------------------------------Rule15--------------------------------------------
    evaluation("   The Evaluation: Your car is a bad and unacceptable option for travel, having a safety system is very important") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        input(automatic_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        not(input(safety)).

%--------------------------------------------Rule16--------------------------------------------
    evaluation("   The Evaluation: Your car as performance and as a driving is suitable, but traveling in this car can be tiring because the seats are not comfortable") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        input(automatic_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        input(safety),
        not(input(seats_comfortable)).

%--------------------------------------------Rule17--------------------------------------------
    evaluation("   The Evaluation: Your car is an acceptable option for travel, no having a fridge does make it unsuitable car") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        input(automatic_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        input(safety),
        input(seats_comfortable),
        not(input(fridge)).

%--------------------------------------------Rule18--------------------------------------------
    evaluation("   The Evaluation: Your car is a perfect option and suitable for travel for long distances with roads without slopes and rough terrain") :-
        input(own_a_car),
        input(travel_time),
        not(input(travel_route)),
        input(automatic_gear),
        input(cylinder),
        input(fuel_economy),
        input(maintenance),
        input(safety),
        input(seats_comfortable),
        input(fridge).
%***************************END OF EVALUATION 2*************************************
% Evaluation 3 : Own or use a car + Travel time is not > 6-8 hours + No slopes or rough terrain -----
%--------------------------------------------Rule19--------------------------------------------
    evaluation("   The Evaluation: Your car is not suitable, it was not well prapared for travel.") :-
        input(own_a_car),
        not(input(travel_time)),
        not(input(maintenance)).

%--------------------------------------------Rule20--------------------------------------------
    evaluation("   The Evaluation: Your car is a bad option for travel, because it is not a safety car. ") :-
        input(own_a_car),
        not(input(travel_time)),
        input(maintenance),
        not(input(safety)).

%--------------------------------------------Rule21--------------------------------------------
    evaluation("   The Evaluation: Your car is acceptable option for travel, but it is not useful. ") :-
        input(own_a_car),
        not(input(travel_time)),
        input(maintenance),
        input(safety),
        not(input(seats_comfortable)).

%--------------------------------------------Rule22--------------------------------------------
    evaluation("   The Evaluation: Your car is suitable and a perfect option for travel. ") :-
        input(own_a_car),
        not(input(travel_time)),
        input(maintenance),
        input(safety),
        input(seats_comfortable).
%***************************END OF EVALUATION 3*************************************
%----------------------------------------End of Evaluations-------------------------------------------------------
%------------------------------------------End Main--------------------------------------------------------------

end implement main

% the goal section which start the program by calling the run procedure

goal
    console::runUtf8(main::run).
%***************************END PROGRAM *********************************************
