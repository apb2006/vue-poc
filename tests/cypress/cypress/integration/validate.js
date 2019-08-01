/**
 * @author andy bunce
 * @description Cypress vue-poc
 */

//This is where your test suite starts

describe('validate tests', function () {

    //This function will execute before each test (i.e it())

    beforeEach(function () {
        cy.log('I run before every test in every spec file!!!!!!')
    })

    //Here you actually writes your test (it() is similar to @Test annotaion of TestNG)

    it('validate', function () {

        //Click on type button
        cy.visit('/ui/validate')
        cy.screenshot("validate/validate")
		cy.get("#btn-clear").click()
		cy.screenshot("validate/clear")
    })	

})