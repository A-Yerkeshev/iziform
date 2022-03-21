class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show edit update destroy]
  before_action :set_form, only: %i[index show new edit create]
  before_action :set_questions, only: %i[show new edit]

  # GET /responses or /responses.json
  def index
    @responses = params[:form_id] ? Response.where(form_id: params[:form_id]) : Response.all
  end

  # GET /responses/1 or /responses/1.json
  def show
    # Because response.content has following format: {question_id: answer}
    # in order to display full response on screen we need to replace content
    # with following format:
    # {
    #   question_text: {
    #     option1: false,
    #     option2: false,
    #     option3: true
    #   }
    # }

    new_content = {}

    @response.content.each do |question_id, answer|
      question = @questions.detect {|q| q.id.to_s == question_id}

      new_content[question.content] = {}

      # Fill new content hash and mark answers based on question type
      case question.question_type
      when 0 # -text
        new_content[question.content][answer] = false
      when 1 # -one choice
        question.options.each do |option|
          new_content[question.content][option] = option == answer
        end
      when 2 # -multiple choice
        question.options.each do |option|
          new_content[question.content][option] = answer.include? option
        end
      end
    end

    @response.content = new_content
  end

  # GET /responses/new
  def new
    @response = Response.new(form_id: @form.id)
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to response_url(@response), notice: "Response was successfully created." }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { redirect_to new_response_path(form_id: @response.form_id), notice: "#{@response.errors.full_messages.join(', ')}" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to response_url(@response), notice: "Response was successfully updated." }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity, flash: { error: 'Response could not be saved' } }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url, notice: "Response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    def set_form
      form_id = params[:form_id] || params.dig(:response, :form_id)
      @form = @response&.form || Form.find_by_id(form_id)

      redirect_to forms_path, flash: { error: 'You must specify form id' } unless @form
    end

    def set_questions
      @questions = @form ? Question.where(form_id: @form.id) : Question.where(form_id: params[:form_id])
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:response).permit(:form_id, :respondent, content:{})

      # # Remove \n and \r characters from the end of response option
      # if params[:content]
      #   params[:content].each do |question_id, answer|
      #     params[:content][question_id] = answer.chop
      #   end
      # end
    end
end
