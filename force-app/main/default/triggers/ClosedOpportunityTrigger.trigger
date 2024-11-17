trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    // List to store tasks that will be created
    List<Task> tasksToInsert = new List<Task>();

    // Iterate through the opportunities in Trigger.new
    for (Opportunity opp : Trigger.new) {
        // Ensure the stage is Closed Won and handle only records that are newly changed or inserted
        if (opp.StageName == 'Closed Won' && 
            (Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(opp.Id).StageName != 'Closed Won'))) {
            
            // Create a follow-up task for the opportunity
            Task newTask = new Task(
                Subject = 'Follow Up Test Task',
                WhatId = opp.Id, // Associate the task with the opportunity
                Status = 'Not Started', // Default task status
                Priority = 'Normal' // Default task priority
            );
            
            // Add the task to the list
            tasksToInsert.add(newTask);
        }
    }

    // Insert the tasks if there are any to insert
    if (!tasksToInsert.isEmpty()) {
        insert tasksToInsert;
    }
}