namespace: ai
flow:
  name: restart_apache_service
  workflow:
    - restart_apache_service:
        do:
          io.cloudslang.base.powershell.powershell_script:
            - host: 172.31.54.247
            - port: '5985'
            - protocol: http
            - username: administrator
            - password:
                value: "${get_sp('aosweb_admin_pwd')}"
                sensitive: true
            - auth_type: basic
            - script: "Restart-Service -Name 'AOS'"
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
