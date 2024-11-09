FROM tensorflow/serving
COPY ./serving_model_dir/ /models/cc-model/

# Mengatur environment variable untuk TensorFlow Serving
ENV MODEL_NAME=cc-model
ENV REST_API_PORT=8501

# Ekspose port yang akan digunakan
EXPOSE 8501

# Menulis custom entrypoint untuk menjalankan TensorFlow Serving
RUN echo '#!/bin/bash \n\n\
env \n\
tensorflow_model_server --port=8500 --rest_api_port=${REST_API_PORT} \
--model_name=${MODEL_NAME} --model_base_path=/models/${MODEL_NAME} \
"$@"' > /usr/bin/tf_serving_entrypoint.sh \
&& chmod +x /usr/bin/tf_serving_entrypoint.sh

# Menetapkan entrypoint untuk menjalankan TensorFlow Serving
ENTRYPOINT ["/usr/bin/tf_serving_entrypoint.sh"]
