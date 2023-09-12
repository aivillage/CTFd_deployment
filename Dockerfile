FROM ctfd/ctfd:3.6.0 as build

COPY gits/llm_verification /opt/CTFd/CTFd/plugins/llm_verification
COPY gits/aiv_ctfd_theme/aiv-beta /opt/CTFd/CTFd/themes/aiv-beta
COPY config/ctfd/.ctfd_secret_key /opt/CTFd/.ctfd_secret_key

RUN pip install --no-cache-dir -r requirements.txt \
    && for d in CTFd/plugins/*; do \
        if [ -f "$d/requirements.txt" ]; then \
            pip install --no-cache-dir -r "$d/requirements.txt";\
        fi; \
    done;


USER 1001
EXPOSE 8000
ENTRYPOINT ["/opt/CTFd/docker-entrypoint.sh"]