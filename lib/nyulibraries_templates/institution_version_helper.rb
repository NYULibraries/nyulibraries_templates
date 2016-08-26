module NyulibrariesTemplates
  module InstitutionVersionHelper
    MAJOR_VERSION_REQUIRED = 1

    def institutions_included?
      institutions_defined? && institution_version_required?
    end

    def institutions_defined?
      defined?(NyulibrariesInstitutions)
    end

    def institution_version_required?
      nyulibraries_institutions_major_version >= MAJOR_VERSION_REQUIRED
    end

    def nyulibraries_institutions_major_version
      NyulibrariesInstitutions::VERSION.split(".").first.to_i
    end
  end
end
