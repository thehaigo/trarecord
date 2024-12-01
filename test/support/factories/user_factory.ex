defmodule Trarecord.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Trarecord.Accounts.User{
          email: sequence(:email, &"user#{&1}@example.com"),
          password: valid_user_password(),
          hashed_password: Pbkdf2.hash_pwd_salt(valid_user_password())
        }
      end

      def user_form_data_factory do
        build(:user, hashed_password: nil)
      end

      def valid_user_password, do: "hello world!"

      def unique_user_email do
        sequence(:unique_user_email, &"user#{&1}@example.com")
      end

      def extract_user_token(fun) do
        {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
        [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
        token
      end
    end
  end
end
