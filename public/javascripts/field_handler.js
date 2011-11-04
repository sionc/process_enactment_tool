var FieldHandler = (function() {
    // private
    var queue = Queue();

    // public
    return {

        modifyEstimatedSize : function() {

        },

        modifyEstimatedProductionRate : function() {
            queue.enqueue('deliverable_estimated_production_rate');

        },

        modifyTotalEffort : function() {
            queue.enqueue('deliverable_estimated_effort');
        },

        getDisabledField : function() {
            return queue.lost();
        }
    }
});