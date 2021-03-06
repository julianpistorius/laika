require File.dirname(__FILE__) + '/../../spec_helper'

describe "encounters/edit.html.erb" do
  fixtures :users

  describe "with an existing encounter (encounters/edit)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @encounter = @patient.encounters.create!
      @encounter.person_name = PersonName.new
      @encounter.address = Address.new
      @encounter.telecom = Telecom.new
      assigns[:encounter] = @encounter
      assigns[:patient] = @patient
    end

    it "should render the edit form with method PUT" do
      render 'encounters/edit'
      response.should have_tag("form[action=#{patient_encounter_path(@patient,@encounter)}]") do
        with_tag "input[name=_method][value=put]"
      end
    end
  end

  describe "without an existing encounter (encounters/new)" do
    before do
      @patient = Patient.create!(:name => 'foo', :user => User.find(:first))
      @encounter = Encounter.new
      @encounter.person_name = PersonName.new
      @encounter.address = Address.new
      @encounter.telecom = Telecom.new
      assigns[:encounter] = @encounter
      assigns[:patient] = @patient
    end

    it "should render the edit form with method POST" do
      render 'encounters/edit'
      response.should have_tag("form[action=#{patient_encounters_path(@patient)}][method=post]") do
        without_tag "input[name=_method][value=put]"
      end
    end
  end

end


