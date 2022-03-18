class FormsController < ApplicationController
  before_action :set_form, only: %i[ show edit update destroy ]

  # GET /forms or /forms.json
  def index
    @forms = Form.all
  end

  # GET /forms/1 or /forms/1.json
  def show
    @questions = @form.questions
  end

  # GET /forms/new
  def new
    @form = Form.new
  end

  # GET /forms/1/edit
  def edit
    # Compile content and options together for editing
    @form.questions.each do |question|
      question.content.concat(question.options.join("\n"))
    end
  end

  # POST /forms or /forms.json
  def create
    @form = Form.new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to form_url(@form), notice: "Form was successfully created." }
        format.json { render :show, status: :created, location: @form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1 or /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to form_url(@form), notice: "Form was successfully updated." }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1 or /forms/1.json
  def destroy
    @form.destroy

    respond_to do |format|
      format.html { redirect_to forms_url, notice: "Form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def form_params
      form_raw_params = params.require(:form).permit(:name, :token, :status, :data, questions_attributes: %i[content question_type _destroy])
      questions_attributes = form_raw_params[:questions_attributes]
      questions_attributes.each do |key, attributes|
        if questions_attributes[key][:question_type] != '0'
          parts = attributes[:content].split("\n")
          questions_attributes[key][:content] = parts[0]
          questions_attributes[key][:options] = parts[1..]
        else
          questions_attributes[key][:options] = []
        end
      end

      form_raw_params[:questions_attributes] = questions_attributes

      form_raw_params
    end
end
