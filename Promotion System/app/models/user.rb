# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validate :email_locaweb

  # def email_locaweb
  #   return if record.email.include? '@locaweb.com.br'
  #     record.errors.add(:email, 'O e-mail precisa ser @locaweb.com.br')
  #   end
end
