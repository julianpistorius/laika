require File.dirname(__FILE__) + '/../../spec_helper'

describe "procedure/edit.html.erb" do
  fixtures :users

  describe "with an existing procedure (procedures/edit)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @procedure = @patient.procedures.create!
      assigns[:patient] = @patient
      assigns[:procedure] = @procedure
    end

    it "should render the edit form with method PUT" do
      render 'procedures/edit'
      response.should have_tag("form[action=#{patient_procedure_path(@patient,@procedure)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing procedure (procedures/new)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @procedure = Procedure.new
      assigns[:patient] = @patient
      assigns[:procedure] = @procedure
    end

    it "should render the edit form with method POST" do
      render 'procedures/edit'
      response.should have_tag("form[action=#{patient_procedures_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


