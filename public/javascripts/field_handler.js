var FieldHandler = (function() {
    // private
    var queue = Queue();

    // public
    return {

        modifyEstimatedSize : function(estimatedSize) {
            if (estimatedSize != '') {
            	queue.enqueue('deliverable_estimated_size');
          	}
        },

        modifyEstimatedProductionRate : function(estimatedProductionRate) {
        	if (estimatedProductionRate != '') {
            queue.enqueue('deliverable_estimated_production_rate');
          }
        },

        modifyEstimatedEffort : function(estimatedEffort) {
        	if (estimatedEffort != '') {
            queue.enqueue('deliverable_estimated_effort');
          }
        },

        getCalculatedField : function() {
            if (queue.contents().length == 2) {
				var fields = ['deliverable_estimated_size', 'deliverable_estimated_production_rate', 'deliverable_estimated_effort'];

                var firstField = fields.indexOf(queue.contents()[0]);
                fields.splice(firstField, 1);

                var secondField = fields.indexOf(queue.contents()[1]);
                fields.splice(secondField, 1);

				// Return the field that doesn't exist in the queue
                return fields[0];
            } else {
	            return null;
			}
        }
    }
});