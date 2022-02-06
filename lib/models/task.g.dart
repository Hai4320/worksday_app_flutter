// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      fields[0] as String,
      fields[1] as String,
      fields[3] as int,
      fields[2] as int,
      fields[8] as int,
    )
      ..more = fields[4] as String
      ..repeat = fields[5] as int
      ..image = fields[6] as String
      ..audio = fields[7] as String
      ..isDone = fields[9] as bool
      ..isShown = fields[10] as bool
      ..repeatWeek = (fields[11] as List).cast<bool>()
      ..repeatMonth = (fields[12] as List).cast<bool>();
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.taskname)
      ..writeByte(2)
      ..write(obj.priority)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.more)
      ..writeByte(5)
      ..write(obj.repeat)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.audio)
      ..writeByte(8)
      ..write(obj.noticetime)
      ..writeByte(9)
      ..write(obj.isDone)
      ..writeByte(10)
      ..write(obj.isShown)
      ..writeByte(11)
      ..write(obj.repeatWeek)
      ..writeByte(12)
      ..write(obj.repeatMonth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeTaskAdapter extends TypeAdapter<TypeTask> {
  @override
  final int typeId = 1;

  @override
  TypeTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeTask(
      name: fields[0] as String,
      color: fields[1] as String,
    )..isDefault = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, TypeTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
