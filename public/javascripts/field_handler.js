var FieldHandler = (function() {
    // private
    var queue = Queue();
    var fields = ['deliverable_estimated_size', 'deliverable_estimated_production_rate', 'deliverable_estimated_effort'];

    // public
    return {

        modifyEstimatedSize : function() {
            queue.enqueue('deliverable_estimated_size');
        },

        modifyEstimatedProductionRate : function() {
            queue.enqueue('deliverable_estimated_production_rate');
        },

        modifyTotalEffort : function() {
            queue.enqueue('deliverable_estimated_effort');
        },

        getDisabledField : function() {
            var lost = queue.lost();
            if (lost == null && queue.contents().length == 2) {

                var firstField = fields.indexOf(queue.contents()[0]);
                fields.splice(firstField, 1);

                var secondField = fields.indexOf(queue.contents()[1]);
                fields.splice(secondField, 1);

                return fields[0];
            }
            return lost;
        }
    }
});