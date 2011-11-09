describe("FieldHandler", function() {

    it("should return that no field is disabled when no fields have been modified",
    function() {
        var fieldHandler = FieldHandler();
        expect(fieldHandler.getDisabledField()).toEqual(null);
    });

    it("should return that no field is disabled when one field has been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize(7);
        expect(fieldHandler.getDisabledField()).toEqual(null);
    });  	

    it("should return that the estimated size field is disabled when the \
        estimated production rate and total effort have been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedProductionRate(8);
        fieldHandler.modifyTotalEffort(9);
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_size");
    });

    it("should return that the estimated production rate field is disabled when the \
        estimated size and total effort have been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize(7);
        fieldHandler.modifyTotalEffort(9);
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_production_rate");
    });

    it("should return that the total effort field is disabled when the \
        estimated size and estimated production rate have been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize(7);
        fieldHandler.modifyEstimatedProductionRate(8);
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_effort");
    });
    
    it("should not enqueue estimated size if empty",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyTotalEffort(9);
        fieldHandler.modifyEstimatedProductionRate(8);
        fieldHandler.modifyEstimatedSize('');
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_size");
    });

    it("should not enqueue estimated production rate if empty",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyTotalEffort(9);
        fieldHandler.modifyEstimatedSize(7);
        fieldHandler.modifyEstimatedProductionRate('');
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_production_rate");
    });
    
    it("should not enqueue total effort if empty",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize(7);
        fieldHandler.modifyEstimatedProductionRate(8);
        fieldHandler.modifyTotalEffort('');
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_effort");
    });
});

