FROM img.plattform.dataplattform.sparebank1.no/dp-dev:main-gitpod

WORKDIR /tmp/work

COPY requirements.txt .

ENV PIP_INDEX_URL=https://nexus.intern.sparebank1.no/repository/pypi-group-packages/simple

RUN pip install --upgrade pip \
  && pip install -r requirements.txt

RUN poetry self update \
  && poetry config virtualenvs.in-project true \
  && poetry config virtualenvs.prefer-active-python true

ENV HOMEBREW_NO_ENV_HINTS=true

RUN brew tap databricks/tap \
  && brew install databricks

RUN sudo touch /etc/bash_completion.d/databricks \
  && sudo chmod o+w /etc/bash_completion.d/databricks \
  && databricks completion bash > /etc/bash_completion.d/databricks \
  && sudo chmod o-w /etc/bash_completion.d/databricks
