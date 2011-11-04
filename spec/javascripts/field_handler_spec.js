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
    
});

