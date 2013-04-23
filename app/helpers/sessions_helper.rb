module SessionsHelper
	def login(user)
		cookies[:remember_token] = {
			:value => user.remember_token,
			:expires => 1.day.from_now
		}
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by(:remember_token => cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end
	
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to login_url, notice: "Please sign in." 
		end
	end

	def logout
		self.current_user = nil
		session.delete(:groups)
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end

	# LDAP-Gruppen: fsinfo, it, ewoche, ausland, kasse, kai, fete, 
	#								fsk, pr, hh, sprecher, fsl, kuehlschrank, datenschutz, vlu, pa, stupa, protokolle, fbr, 
	#								fit, events, homepage, kommunikation, fsr, ausleihe, oe
	def has_group?(group)
		# TODO: remove return true
		return true

		ldap = Net::LDAP.new(:host => 'ford.fachschaft.informatik.uni-kl.de')
		if ldap.bind
			filter = Net::LDAP::Filter.eq('memberUid', current_user.loginname)
			groups = ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter, :attributes => ['cn']).flat_map(&:cn)
			return groups.include?(group)
		else
			return false
		end
	end
end
