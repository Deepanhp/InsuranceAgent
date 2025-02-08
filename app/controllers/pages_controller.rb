class PagesController < ApplicationController
  def home
  end

  def about
  end

  def services
  end

  def contact
  end

  def testimonials
  end

  def products
  end

  def calculators
  end

  def calculate_premium
    calculator_type = params[:calculator_type]
    result = case calculator_type
    when 'term'
      calculate_term_insurance
    when 'endowment'
      calculate_endowment
    when 'pension'
      calculate_pension
    when 'child'
      calculate_child_plan
    end

    render json: { premium: result }
  end

  def submit_contact
    @contact = Contact.new(contact_params)
    
    if @contact.save
      flash[:notice] = "Thank you for your message! We'll get back to you soon."
    else
      flash[:alert] = "There was a problem sending your message. Please try again."
    end
    
    redirect_to contact_path
  end

  private

  def contact_params
    params.permit(:name, :email, :phone, :subject, :message)
  end

  # LIC Premium calculation methods
  def calculate_term_insurance
    age = params[:age].to_i
    sum_assured = params[:sum_assured].to_f
    term = params[:term].to_i
    
    # LIC Term Insurance Premium Calculation (approximate formula)
    base_rate = case age
    when 18..25 then 0.8
    when 26..35 then 1.0
    when 36..45 then 1.5
    when 46..55 then 2.5
    else 4.0
    end
    
    annual_premium = (sum_assured * base_rate * term) / 1000
    (annual_premium * (1 + 0.18)).round(2) # Adding 18% GST
  end

  def calculate_endowment
    age = params[:age].to_i
    sum_assured = params[:sum_assured].to_f
    term = params[:term].to_i
    
    # LIC Endowment Plan Premium Calculation (approximate formula)
    base_rate = case age
    when 18..25 then 45
    when 26..35 then 50
    when 36..45 then 55
    when 46..55 then 60
    else 70
    end
    
    annual_premium = (sum_assured * base_rate) / 1000
    (annual_premium * (1 + 0.18)).round(2) # Adding 18% GST
  end

  def calculate_pension
    age = params[:age].to_i
    monthly_pension = params[:monthly_pension].to_f
    retirement_age = params[:retirement_age].to_i
    
    # LIC Pension Plan Premium Calculation (approximate formula)
    years_to_retirement = retirement_age - age
    total_pension_corpus = monthly_pension * 12 * 20 # Assuming 20 years post retirement
    
    annual_premium = (total_pension_corpus / years_to_retirement) * 0.1
    (annual_premium * (1 + 0.18)).round(2) # Adding 18% GST
  end

  def calculate_child_plan
    child_age = params[:child_age].to_i
    sum_assured = params[:sum_assured].to_f
    term = params[:term].to_i
    
    # LIC Child Plan Premium Calculation (approximate formula)
    base_rate = case child_age
    when 0..5 then 40
    when 6..10 then 45
    when 11..15 then 50
    else 55
    end
    
    annual_premium = (sum_assured * base_rate) / 1000
    (annual_premium * (1 + 0.18)).round(2) # Adding 18% GST
  end
end
