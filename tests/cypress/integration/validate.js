/**
 * @author andy bunce
 * @description Cypress vue-poc
 */

//This is where your test suite starts

describe('validate tests', function () {


    //Here you actually writes your test (it() is similar to @Test annotaion of TestNG)

    it('validate', function () {

        //Click on type button
        cy.visit('/ui/validate')
        cy.screenshot("validate/validate")
		cy.get("#btn-clear").click()
		cy.screenshot("validate/clear")
    })	

})