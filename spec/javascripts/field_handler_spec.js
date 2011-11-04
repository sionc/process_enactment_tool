describe("FieldHandler", function() {

    it("should return that no field is disabled when no fields have been modified",
    function() {
        var fieldHandler = FieldHandler();
        expect(fieldHandler.getDisabledField()).toEqual(null);
    });

    it("should return that no field is disabled when one field has been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize();
        expect(fieldHandler.getDisabledField()).toEqual(null);
    });  	

    it("should return that the estimated size field is disabled when the \
        estimated production rate and total effort have been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedProductionRate();
        fieldHandler.modifyTotalEffort();
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_size");
    });

    it("should return that the estimated production rate field is disabled when the \
        estimated size and total effort have been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize();
        fieldHandler.modifyTotalEffort();
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_production_rate");
    });

    it("should return that the total effort field is disabled when the \
        estimated size and estimated production rate have been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize();
        fieldHandler.modifyEstimatedProductionRate();
        expect(fieldHandler.getDisabledField()).toEqual("deliverable_estimated_effort");
    });
    
});

