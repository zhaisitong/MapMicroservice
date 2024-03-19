FROM zhaisitong/base:latest

WORKDIR /home/MapMicroservice-main

CMD ["python3",                                                                     \
    "-m",                                                                           \
    "src.navigation.main_initialize_map",                                           \
    "--navigation_db_host=34.135.133.217",   \
    "--navigation_db_user=postgres",                                                \
    "--navigation_db_password=12345678"]
